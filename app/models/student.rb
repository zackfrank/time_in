class Student < ApplicationRecord
  belongs_to :account
  has_many :users
  has_many :bookings
end
