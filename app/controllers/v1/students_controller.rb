class V1::StudentsController < ApplicationController

  def index
    render json: Student.all.as_json
  end

  def create
  end

  def show
    students = Student.where(account_id: params[:id])
    render json: students.as_json
  end

end
