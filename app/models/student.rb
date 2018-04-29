class Student < ApplicationRecord
  belongs_to :account
  has_many :bookings


  def as_json
    {
      first_name: first_name,
      last_name: last_name,
      birthday: birthday.strftime("%m/%d/%Y"),
      high_school: high_school,
      active: active?,
      account_id: account_id
    }
  end

end
