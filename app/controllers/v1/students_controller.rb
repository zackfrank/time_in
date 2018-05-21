class V1::StudentsController < ApplicationController

  def index
    students = Student.all.order(:last_name)
    render json: students.as_json
  end

  def create
    student = Student.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      high_school: params[:high_school],
      birthday: params[:birthday],
      account_id: params[:account_id],
      active?: true
      )

    if student.save
      render json: student.as_json
    else
      render json: {error: student.errors.full_messages}
    end
  end

  def show
    students = Student.where(account_id: params[:id]).order(:created_at) # not tested with order added
    render json: students.as_json
  end

  def update
    student = Student.find(params[:id])

    student.first_name = params[:first_name] || student.first_name
    student.last_name = params[:last_name] || student.last_name
    student.birthday = params[:birthday] || student.birthday
    
    if params[:high_school]
      student.high_school = !student.high_school
    end
    
    if params[:active]
      student[:active?] = !student[:active?]
    end

    if student.save
      render json: student.as_json
    else
      render json: {error: student.errors.full_messages}
    end
  end

end
