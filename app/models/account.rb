class Account < ApplicationRecord
  has_many :users
  has_many :students
  has_many :bookings

  def as_json
    {
      id: id,
      name: name,
      admin: admin,
      users: users.sort_by {|user| user.created_at}.map {|user| 
        {
          id: user.id,
          first_name: user.first_name, 
          last_name: user.last_name, 
          email: user.email, 
          relationship: user.relationship, 
          phone_number: user.phone_number, 
          active: user.active? 
        }
      },
      students: students.sort_by {|student| student.created_at}.map {|student| 
        {
          id: student.id,
          first_name: student.first_name, 
          last_name: student.last_name, 
          birthday: student.birthday, 
          high_school: student.high_school,
          active: student.active? 
        }
      }
    }
  end
end
