class User < ApplicationRecord
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :account_id, presence: true
  
  belongs_to :account
  has_many :students
  has_many :bookings
end
