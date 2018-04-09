class Account < ApplicationRecord
  has_many :users
  has_many :students
  has_many :bookings
end
