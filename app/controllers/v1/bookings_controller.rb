class V1::BookingsController < ApplicationController
  before_action :authenticate_user

  def index
    # Get all bookings from all students of current user's account - regardless of who booked (ie admin)
    bookings = current_user.account.students.map { |student| student.bookings }
    bookings = bookings.flatten

    render json: bookings.as_json
  end

  def create
    # Wrapped in 'if/else' to prevent duplicate bookings:
    if AttendanceRecord.find(params[:ar_id]).bookings.map {|booking| booking.student_id }.include? params[:student_id]
      render json: {error: "Student is already booked at this time. Please check your schedule or call center."}
    else
      booking = Booking.new(
        student_id: params[:student_id],
        user_id: current_user.id,
        attendance_record_id: params[:ar_id]
        )

      # If admin, status is always "Booked". 
      # If AR is at capacity, status is "Standby", otherwise just "Booked"
      current_user.account.admin ? booking.status = "Booked" : booking.set_booking_status(params[:ar_id])

      if booking.save
        booking.send_confirmation_text(params[:date], params[:time], params[:student_id])
        render json: booking.as_json
      else
        render json: {errors: booking.errors.full_messages}, status: :bad_request
      end
    end
  end

  def show
    booking = Booking.find(params[:id])
    render json: booking.as_json
  end

  def update
    booking = Booking.find(params[:id])
    booking.status_update(params[:status])

    render json: {message: "Booking successfully updated."}
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy

    render json: {message: "Booking successfully deleted."}
  end

end
