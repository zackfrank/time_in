class Account < ApplicationRecord
  has_many :users
  has_many :students
  has_many :bookings

  def as_json
    {
      id: id,
      name: name,
      admin: admin,
      users: users.map {|user| 
        {
          first_name: user.first_name, 
          last_name: user.last_name, 
          email: user.email, 
          relationship: user.relationship, 
          phone_number: user.phone_number, 
          active: user.active? 
        }
      },
      students: students.map {|student| 
        {
          first_name: student.first_name, 
          last_name: student.last_name, 
          birthday: student.birthday, 
          high_school: student.high_school 
        }
      }
    }
  end
end
