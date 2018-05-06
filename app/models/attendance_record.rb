class AttendanceRecord < ApplicationRecord
  has_many :bookings
  has_many :students, through: :bookings
  has_many :users, through: :bookings

  def space_left
    bookings = Booking.where(attendance_record_id: id).length
    remaining_spots = capacity - bookings
    return remaining_spots
  end

  def high_school?
    time == "7:00 PM" ? true : false
  end

  def gcal_date
    time_string = Time.parse(time).to_s.split(' ')[1].gsub(/[^0-9A-Za-z]/, '') # convert time string to format: "030000"
    time_string_24hr = time_string.to_i < 120000 ? (time_string.to_i + 120000).to_s : time_string # ensure time in 24hr format: "150000"
    time_argument = "%Y%m%dT#{time_string_24hr}"
    part1 = date.strftime(time_argument)
    # Plus one hour
    time_string2_24hr = time_string.to_i < 120000 ? (time_string.to_i + 130000).to_s : (time_string.to_i + 10000).to_s # ensure time in 24hr format
    time_argument = "%Y%m%dT#{time_string2_24hr}"
    part2 = date.strftime(time_argument)
    "#{part1}/#{part2}"
  end

  def as_json
    {
      id: id,
      date: date.strftime("%a, %b %e, %Y"),
      gcal_date: gcal_date,
      weekday: date.strftime('%A'),
      time: time,
      capacity: capacity,
      space_left: space_left,
      high_school: high_school?,
      week_number: date.strftime("%U").to_i,
      current_week_number: Time.now.strftime("%U").to_i,
      bookings: bookings.map {|booking| {
        student: booking.student.first_name + " " + booking.student.last_name,
        booked_by: booking.booked_by,
        birthday: booking.student.birthday,
        high_school: booking.student.high_school,
        status: booking.status} 
      }
    }
  end

end
