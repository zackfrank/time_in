class Booking < ApplicationRecord
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

  def as_json
    student = Student.find_by(id: self.student_id)
    user = User.find_by(id: self.user_id)
    ar = AttendanceRecord.find_by(id: self.attendance_record_id)
    {
      id: id,
      student: student.first_name,
      booked_by: user.first_name + " " + user.last_name,
      date: ar.date.strftime("%a %b %e %Y"),
      time: ar.time,
      status: status,
      admin_booking: admin_booking,
    }
  end

end
