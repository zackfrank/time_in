class Carpool < ApplicationRecord
  has_many :bookings
  belongs_to :attendance_record
  serialize :waypoints, Array

  def mapped_bookings
    formatted_bookings = bookings.map {|booking| 
      {
        id: booking.id,
        student: booking.student.first_name,
        booked_by: 
          {
            id: booking.user.id,
            first_name: booking.user.first_name, 
            last_name: booking.user.last_name,
            address: booking.user.address,
            zip: booking.user.zip
          },
        status: booking.status
      }
    }
    return formatted_bookings
  end

  # def add_carpool_to_booking(params)
  #   if params[:booking_id]
  #     @booking = Booking.find(params[:booking_id])
  #     @booking.carpool_id = params[:id]
  #     @booking.save
  #   end
  # end

  # def update_carpool(params)
  #   @carpool = Carpool.find(params[:id])
  #   if params[:waypoint]
  #     unless (@carpool.waypoints.include? params[:waypoint]) do
  #       @carpool.waypoints << params[:waypoint]
  #     end
  #   end
  #   if params[:start]
  #     @carpool.start = params[:start]
  #   end
  #   @carpool.save
  # end

  def as_json
    {
      id: id,
      name: name,
      start: start,
      waypoints: waypoints,
      date: attendance_record.date.strftime("%a, %b %e, %Y"),
      time: attendance_record.time,
      spots: spots,
      bookings: mapped_bookings
    }
  end
end
