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
