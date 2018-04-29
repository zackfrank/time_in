class V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users.as_json
  end

  def create
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      relationship: params[:relationship],
      active?: true
      )

    # if (account = Account.find_by(name: params[:account_name]))
    #   user.account_id = account.id
    # elsif params[:account_name]
    #   account = Account.create(
    #     name: params[:account_name],
    #     admin: false
    #     )
    # end

    if user.save
      render json: user.as_json
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end

  end

  def show
    render json: current_user.as_json
  end
end
