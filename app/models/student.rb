class Student < ApplicationRecord
  belongs_to :account
  has_many :bookings

  def birthday?
    birthday.to_time.strftime("%W") == Time.now.strftime("%W")
  end

  def as_json
    {
      id: id,
      full_name: first_name + " " + last_name,
      first_name: first_name,
      last_name: last_name,
      birthday: birthday.strftime("%m/%d/%Y"),
      birthday?: birthday?,
      high_school: high_school,
      active: active?,
      account_id: account_id
    }
  end

end
