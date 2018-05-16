class Carpool < ApplicationRecord
  has_many :bookings
  belongs_to :attendance_record
  belongs_to :user
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
  #   carpool = Carpool.find(params[:id])
  #   if params[:waypoint] && (params[:waypoint] != "")
  #     unless (carpool.waypoints.include? params[:waypoint])
  #       carpool.waypoints << params[:waypoint]
  #     end
  #   end

  #   if params[:start] 
  #     # move current starting address into waypoints
  #     unless (carpool.waypoints.include? carpool.start)
  #       carpool.waypoints << carpool.start
  #     end
  #     # remove starting address from waypoints (if it's in there)
  #     if carpool.waypoints.include? params[:start]
  #       carpool.waypoints.delete(params[:start])
  #     end
  #     carpool.start = params[:start]
  #   end

  #   carpool.save
  # end

  def as_json
    {
      id: id,
      name: name,
      user: user.as_json,
      start: start,
      waypoints: waypoints,
      request: request,
      date: attendance_record.date.strftime("%a, %b %e, %Y"),
      time: attendance_record.time,
      spots: spots,
      bookings: mapped_bookings
    }
  end
end
