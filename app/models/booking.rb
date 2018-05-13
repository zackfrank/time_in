class Booking < ApplicationRecord
  require 'twilio-ruby'
  belongs_to :student
  belongs_to :user
  belongs_to :attendance_record
  belongs_to :carpool, optional: true

  def set_booking_status(ar_id) # For Bookings#create
    ar = AttendanceRecord.find(ar_id)
    number_currently_attending = Booking.where(attendance_record_id: ar.id).length
    number_currently_attending < ar.capacity ? self.status = "Booked" : self.status = "Standby"
  end

  def status_update(status) # for Bookings#update and to address standby list
    # Basic function:
    self.status = status
    self.save
    
    # AR attributes:
    ar_id = self.attendance_record_id
    ar = AttendanceRecord.find(ar_id)
    date = ar.date.strftime("%a, %b %e %Y")
    time = ar.time

    # Send confirmation text for "Booked" session:
    if self.status == "Booked" 
      self.send_confirmation_text(date, time, self.student_id)
    end

    # Find next (first) standby waiting to join session if space is made available
    if (status == "Cancelled") && (Booking.where(attendance_record_id: ar_id, status: "Booked").length < 10)
      first_standby_booking = Booking.where(status: "Standby", attendance_record_id: ar_id).order(:updated_at)[0]
    end

    # Send text to first "Standby" booking and give ability to switch to "Booked" or cancel
    if first_standby_booking
      first_standby_booking.offer_booking
    end
  end

  def offer_booking # for standby users
    # Send text
    account_sid = ENV['account_sid']
    auth_token = ENV['auth_token']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = ENV['twilio_number'] # Your Twilio number
    to = ENV['my_phone_number'] # Your mobile phone number (change to user #)
    student = Student.find(self.student_id).first_name
    date = self.attendance_record.date.strftime("%a, %b %e %Y")
    time = self.attendance_record.time

    client.messages.create(
    from: from,
    to: to,
    body: 
    "Standby Mathnasium session for #{student} at #{time} on #{date} is NOW AVAILABLE!
    Please sign into your account and navigate to 'Schedule' to officially opt-in (any other session for #{student} on this date will automatically be cancelled). 
    If no longer interested in this session, please CANCEL to make room for others."
    )

    # Change status to allow opt-in
    self.status = "Opt-in"
    self.save
  end

  def at_capacity # not being used
    bookings = Bookings.where(attendance_record_id: ar.id)
    bookings.length < 10 ? true : false
  end

  def current_attendance
    bookings = Bookings.where(attendance_record_id: ar.id)
    bookings.length
  end

  def booked_by
    user.first_name + " " + user.last_name
  end

  def send_confirmation_text(date, time, id)
    account_sid = ENV['account_sid']
    auth_token = ENV['auth_token']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = ENV['twilio_number'] # Your Twilio number
    to = ENV['my_phone_number'] # Your mobile phone number
    student = Student.find(id).first_name

    if self.status == "Booked"
      client.messages.create(
      from: from,
      to: to,
      body: "Mathnasium session booked for #{student} at #{time} on #{date}."
      )
    elsif self.status == "Standby"
      client.messages.create(
      from: from,
      to: to,
      body: "#{student} is on STANDBY for a Mathnasium session at #{time} on #{date}."
      )
    end
  end

  def as_json
    student = Student.find_by(id: self.student_id)
    user = User.find_by(id: self.user_id)
    ar = AttendanceRecord.find_by(id: self.attendance_record_id)
    {
      id: id,
      student: student.first_name,
      booked_by: booked_by,
      user_address: user.address + " " + user.zip,
      attendance_record_id: ar.id,
      date: ar.date.strftime("%a, %b %e %Y"),
      time: ar.time,
      status: status,
      carpool: carpool ? {id: carpool.id, name: carpool.name} : nil
    }
  end

end
