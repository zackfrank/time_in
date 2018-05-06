class Booking < ApplicationRecord
  require 'twilio-ruby'
  belongs_to :student
  belongs_to :user
  belongs_to :attendance_record

  def at_capacity
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

    client.messages.create(
    from: from,
    to: to,
    body: "Mathnasium session booked for #{student} at #{time} on #{date}."
    )
  end

  def as_json
    student = Student.find_by(id: self.student_id)
    user = User.find_by(id: self.user_id)
    ar = AttendanceRecord.find_by(id: self.attendance_record_id)
    {
      id: id,
      student: student.first_name,
      booked_by: booked_by,
      date: ar.date.strftime("%a %b %e %Y"),
      time: ar.time,
      status: status,
      admin_booking: admin_booking,
    }
  end

end
