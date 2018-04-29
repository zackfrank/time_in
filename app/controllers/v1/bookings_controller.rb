class V1::BookingsController < ApplicationController
  before_action :authenticate_user

  def index
    bookings = Booking.where(user_id: current_user.id)
    render json: bookings.as_json
  end

  def create
    booking = Booking.new(
      student_id: Student.find_by(first_name: params[:student]).id,
      user_id: current_user.id,
      admin_booking: false
      )

    # if attendance_record exists, use id, otherwise create new one
    if ( ar = AttendanceRecord.find_by(date: params[:date], time: params[:time]) )
      booking.attendance_record_id = ar.id
      # if AR at capacity status is "standby_booked", otherwise just "booked"
      number_currently_attending = Booking.where(attendance_record_id: ar.id).length
      if current_user.account.admin
        booking.status = "booked"
        booking.admin_booking = true
        ar.capacity += 1
        ar.save
      else
        number_currently_attending < ar.capacity ? booking.status = "booked" : booking.status = "standby-booked"
      end
    else
      ar = AttendanceRecord.create(
        date: params[:date],
        time: params[:time],
        capacity: 10
        )
      booking.attendance_record_id = ar.id
      booking.status = "booked"
    end

    if booking.save
      render json: booking.as_json
    else
      render json: {errors: booking.errors.full_messages}, status: :bad_request
    end
  end

  def show

  end

  def destroy
    
  end

end
