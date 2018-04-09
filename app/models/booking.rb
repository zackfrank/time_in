class Booking < ApplicationRecord
  belongs_to :student
  belongs_to :user
  belongs_to :time_slot
end
