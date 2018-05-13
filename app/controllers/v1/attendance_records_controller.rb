class V1::AttendanceRecordsController < ApplicationController
  before_action :authenticate_user

  def index
    records = AttendanceRecord.all.order(:id)
    # Logic here to push "Opt-In status to front"
    render json: records.as_json
  end

  def create
    
  end
end
