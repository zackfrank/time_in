class V1::AccountsController < ApplicationController
  before_action :authenticate_user
  
  def index
    accounts = Account.all
    render json: accounts.as_json
  end

  def create
    account = Account.new(
      name: params[:name],
      admin: false
      )

    if account.save
      render json: account.as_json
    else
      render json: {errors: account.errors.full_messages}, status: :bad_request
    end
  end

  def show
    account = Account.find_by(id: params[:id])
    
    if account
      render json: account.as_json
    else 
      render json: {message: "There were errors"}, status: :bad_request
    end
  end

end
