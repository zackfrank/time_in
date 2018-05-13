class V1::CarpoolsController < ApplicationController
  def index
    if params[:attendance_record_id]
      carpools = Carpool.where(attendance_record_id: params[:attendance_record_id])
    else
      carpools = Carpool.all
    end
    render json: carpools.as_json
  end

  def update
    # refactor by moving logic to model
    carpool = Carpool.find(params[:id])
    if params[:waypoint]
      unless (carpool.waypoints.include? params[:waypoint])
        carpool.waypoints << params[:waypoint]
      end
    end

    if params[:start]
      carpool.start = params[:start]
    end

    carpool.save   

    if params[:booking_id]
      booking = Booking.find(params[:booking_id])
      booking.carpool_id = params[:id]
      booking.save
    end

    render json: {carpool: carpool.as_json}
  end

  def create
    carpool = Carpool.new(
      name: params[:name],
      attendance_record_id: params[:ar_id],
      start: params[:start],
      spots: params[:spots]
      )
    carpool.save

    booking = Booking.find(params[:booking_id])
    booking.carpool_id = carpool.id
    booking.save
    
    render json: carpool.as_json
  end

  def show
    carpool = Carpool.find(params[:id])
    render json: carpool.as_json
  end

  def destroy
    carpool = Carpool.find(params[:id])
    carpool.destroy
    render json: {message: "Carpool successfully deleted."}
  end
end
