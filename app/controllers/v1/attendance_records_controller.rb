class V1::AttendanceRecordsController < ApplicationController
  before_action :authenticate_user

  def index
    render json: AttendanceRecord.all.as_json
  end
end
