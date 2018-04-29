class AttendanceRecord < ApplicationRecord
  has_many :bookings
  has_many :students, through: :bookings
  has_many :users, through: :bookings

  def space_left
    bookings = Booking.where(attendance_record_id: id).length
    remaining_spots = capacity - bookings
    return remaining_spots
  end

  def as_json
    {
      date: date,
      time: time,
      capacity: capacity,
      space_left: space_left
    }
  end

end
