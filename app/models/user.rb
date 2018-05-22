class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  # validates :account_id, presence: true
  
  belongs_to :account
  has_many :carpools
  has_many :bookings
  has_many :attendance_records, through: :bookings

  def update_info(params)
    if params[:active]
      user[:active?] = !user[:active?]
    end

    self.first_name = params[:first_name] || self.first_name
    self.last_name = params[:last_name] || self.last_name
    self.email = params[:email] || self.email
    self.relationship = params[:relationship] || self.relationship
    self.phone_number = params[:phone_number] || self.phone_number
    self.address = params[:address] || self.address
    self.zip = params[:zip] || self.zip
  end


  def as_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email,
      # account: account,
      address: address,
      zip: zip,
      account_id: account_id,
      relationship: relationship,
      phone_number: phone_number,
      active: active?
    }
  end
end
