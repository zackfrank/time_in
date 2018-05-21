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
      phone_number: params[:phone_number],
      address: params[:address],
      zip: params[:zip],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      relationship: params[:relationship],
      active?: true
      )

    if (account = Account.find(params[:account_id]))
      user.account_id = account.id
    elsif params[:account]
      account = Account.create(
        name: params[:account],
        admin: false
        )
    end

    if user.save
      render json: user.as_json
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end

  end

  def update
    user = User.find(params[:id])
    if params[:active]
      user[:active?] = !user[:active?]
    end

    if user.save
      render json: user.as_json
    else
      render json: {error: user.errors.full_messages}
    end
  end

  def show
    render json: current_user.as_json
  end
end
