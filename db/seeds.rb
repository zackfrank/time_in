# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Account.create(name: "Admin", admin: true)
# Account.create(name: "Andrews", admin: false)
# Account.create(name: "Black", admin: false)
# Account.create(name: "Carter", admin: false)
# Account.create(name: "Dickson", admin: false)
# Account.create(name: "Edwards", admin: false)
# Account.create(name: "Freeman", admin: false)
# Account.create(name: "Goldberg", admin: false)
# Account.create(name: "Harrison", admin: false)

# User.create(first_name: "Zack", last_name: "Frank", email: "zack@email.com", password: "password", account_id: 1, relationship: "admin", phone_number: "(740)507-7529", active?: true)
# User.create(first_name: "Angela", last_name: "Andrews", email: "angela@email.com", password: "password", account_id: 2, relationship: "parent", phone_number: "(123)456-7890", active?: true)
# User.create(first_name: "Brad", last_name: "Black", email: "brad@email.com", password: "password", account_id: 3, relationship: "parent", phone_number: "(123)456-7891", active?: true)
# User.create(first_name: "Arthur", last_name: "Andrews", email: "arthur@email.com", password: "password", account_id: 2, relationship: "sibling", phone_number: "(123)456-7892", active?: true)
# User.create(first_name: "Carl", last_name: "Carter", email: "carl@email.com", password: "password", account_id: 4, relationship: "parent", phone_number: "(123)456-7893", active?: true)
# User.create(first_name: "Debbie", last_name: "Dickson", email: "debbie@email.com", password: "password", account_id: 5, relationship: "parent", phone_number: "(123)456-7894", active?: true)
# User.create(first_name: "David", last_name: "Dickson", email: "david@email.com", password: "password", account_id: 5, relationship: "parent", phone_number: "(123)456-7895", active?: true)
# User.create(first_name: "Eliza", last_name: "Edwards", email: "eliza@email.com", password: "password", account_id: 6, relationship: "grandparent", phone_number: "(123)456-7896", active?: true)
# User.create(first_name: "Fred", last_name: "Freeman", email: "fred@email.com", password: "password", account_id: 7, relationship: "parent", phone_number: "(123)456-7897", active?: true)
# User.create(first_name: "Fran", last_name: "Quincy", email: "fran@email.com", password: "password", account_id: 7, relationship: "babysitter", phone_number: "(123)456-7898", active?: true)
# User.create(first_name: "Gregory", last_name: "Goldberg", email: "gregory@email.com", password: "password", account_id: 8, relationship: "parent", phone_number: "(123)456-7899", active?: true)
# User.create(first_name: "Gina", last_name: "Goldberg", email: "gina@email.com", password: "password", account_id: 8, relationship: "parent", phone_number: "(123)456-7880", active?: true)
# User.create(first_name: "Henry", last_name: "Harrison", email: "henry@email.com", password: "password", account_id: 9, relationship: "parent", phone_number: "(123)456-7881", active?: true)
# User.create(first_name: "Henrietta", last_name: "Quincy", email: "henrietta@email.com", password: "password", account_id: 9, relationship: "babysitter", phone_number: "(123)456-7882", active?: true)


# Student.create(first_name: "Ashley", last_name: "Andrews", high_school: true, account_id: 2, active?: true, birthday: "2001-01-01")
# Student.create(first_name: "Alex", last_name: "Andrews", high_school: false, account_id: 2, active?: true, birthday: "2005-02-01")
# Student.create(first_name: "Bella", last_name: "Black", high_school: false, account_id: 3, active?: true, birthday: "2005-02-15")
# Student.create(first_name: "Chris", last_name: "Carter", high_school: true, account_id: 4, active?: true, birthday: "2001-03-01")
# Student.create(first_name: "Daniel", last_name: "Dickson", high_school: false, account_id: 5, active?: true, birthday: "2005-03-15")
# Student.create(first_name: "Dylan", last_name: "Dickson", high_school: false, account_id: 5, active?: true, birthday: "2007-04-01")
# Student.create(first_name: "Dana", last_name: "Dickson", high_school: false, account_id: 5, active?: true, birthday: "2009-04-15")
# Student.create(first_name: "Emilie", last_name: "Edwards", high_school: true, account_id: 6, active?: true, birthday: "2002-05-01")
# Student.create(first_name: "Eli", last_name: "Edwards", high_school: false, account_id: 6, active?: true, birthday: "2006-05-15")
# Student.create(first_name: "Felipe", last_name: "Freeman", high_school: false, account_id: 7, active?: true, birthday: "2007-06-01")
# Student.create(first_name: "Fernando", last_name: "Freeman", high_school: true, account_id: 7, active?: true, birthday: "2005-06-15")
# Student.create(first_name: "Gabe", last_name: "Goldberg", high_school: true, account_id: 8, active?: true, birthday: "2003-07-01")
# Student.create(first_name: "Gavin", last_name: "Goldberg", high_school: false, account_id: 8, active?: true, birthday: "2010-07-15")
# Student.create(first_name: "Grant", last_name: "Goldberg", high_school: false, account_id: 8, active?: true, birthday: "2007-8-01")
# Student.create(first_name: "Haley", last_name: "Harrison", high_school: false, account_id: 9, active?: true, birthday: "2006-8-15")
# Student.create(first_name: "Hannah", last_name: "Harrison", high_school: false, account_id: 9, active?: true, birthday: "2006-9-01")

# Booking.create(status: "booked-fulfilled", student_id: 1, user_id: 2, attendance_record_id: 1, admin_booking: false)
# Booking.create(status: "booked-fulfilled", student_id: 2, user_id: 4, attendance_record_id: 1, admin_booking: false)
# Booking.create(status: "booked", student_id: 1, user_id: 2, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 2, user_id: 4, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 3, user_id: 3, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 4, user_id: 5, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 5, user_id: 6, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 6, user_id: 6, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 7, user_id: 6, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 8, user_id: 8, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "booked", student_id: 9, user_id: 8, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "cancelled", student_id: 10, user_id: 9, attendance_record_id: 2, admin_booking: false)
# Booking.create(status: "standby-booked", student_id: 11, user_id: 9, attendance_record_id: 2, admin_booking: false)

# AttendanceRecord.create(date: "2018-4-8", time: "10:00 AM", capacity: 10)
# AttendanceRecord.create(date: "2018-4-9", time: "3:30 PM", capacity: 10)

# AttendanceRecord.create([
#   {date: "2018-4-30", time: "3:30 PM", capacity: 10},
#   {date: "2018-4-30", time: "4:00 PM", capacity: 10},
#   {date: "2018-4-30", time: "4:30 PM", capacity: 10},
#   {date: "2018-4-30", time: "5:00 PM", capacity: 10},
#   {date: "2018-4-30", time: "5:30 PM", capacity: 10},
#   {date: "2018-4-30", time: "6:00 PM", capacity: 10},
#   {date: "2018-4-30", time: "6:30 PM", capacity: 10},
#   {date: "2018-4-30", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-1", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-1", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-1", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-1", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-1", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-1", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-1", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-1", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-2", time: "3:00 PM", capacity: 10},
#   {date: "2018-5-2", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-2", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-2", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-2", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-2", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-2", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-2", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-2", time: "7:00 PM", capacity: 10},  
#   {date: "2018-5-3", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-3", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-3", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-3", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-3", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-3", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-3", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-3", time: "7:00 PM", capacity: 10}, 
#   {date: "2018-5-5", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-5", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-5", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-5", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-5", time: "12:00 PM", capacity: 10}, 
#   {date: "2018-5-6", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-6", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-6", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-6", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-6", time: "12:00 PM", capacity: 10},
#   {date: "2018-5-7", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-7", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-7", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-7", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-7", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-7", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-7", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-7", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-8", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-8", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-8", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-8", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-8", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-8", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-8", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-8", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-9", time: "3:00 PM", capacity: 10},
#   {date: "2018-5-9", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-9", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-9", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-9", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-9", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-9", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-9", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-9", time: "7:00 PM", capacity: 10},  
#   {date: "2018-5-10", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-10", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-10", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-10", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-10", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-10", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-10", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-10", time: "7:00 PM", capacity: 10}, 
#   {date: "2018-5-12", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-12", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-12", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-12", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-12", time: "12:00 PM", capacity: 10}, 
#   {date: "2018-5-13", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-13", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-13", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-13", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-13", time: "12:00 PM", capacity: 10},
#   {date: "2018-5-14", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-14", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-14", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-14", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-14", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-14", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-14", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-14", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-15", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-15", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-15", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-15", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-15", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-15", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-15", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-15", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-16", time: "3:00 PM", capacity: 10},
#   {date: "2018-5-16", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-16", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-16", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-16", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-16", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-16", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-16", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-16", time: "7:00 PM", capacity: 10},  
#   {date: "2018-5-17", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-17", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-17", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-17", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-17", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-17", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-17", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-17", time: "7:00 PM", capacity: 10}, 
#   {date: "2018-5-19", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-19", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-19", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-19", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-19", time: "12:00 PM", capacity: 10}, 
#   {date: "2018-5-20", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-20", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-20", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-20", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-20", time: "12:00 PM", capacity: 10},
#   {date: "2018-5-21", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-21", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-21", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-21", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-21", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-21", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-21", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-21", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-22", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-22", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-22", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-22", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-22", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-22", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-22", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-22", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-23", time: "3:00 PM", capacity: 10},
#   {date: "2018-5-23", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-23", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-23", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-23", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-23", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-23", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-23", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-23", time: "7:00 PM", capacity: 10},  
#   {date: "2018-5-24", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-24", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-24", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-24", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-24", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-24", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-24", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-24", time: "7:00 PM", capacity: 10}, 
#   {date: "2018-5-26", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-26", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-26", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-26", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-26", time: "12:00 PM", capacity: 10}, 
#   {date: "2018-5-27", time: "10:00 PM", capacity: 10},
#   {date: "2018-5-27", time: "10:30 PM", capacity: 10},
#   {date: "2018-5-27", time: "11:00 PM", capacity: 10},
#   {date: "2018-5-27", time: "11:30 PM", capacity: 10},
#   {date: "2018-5-27", time: "12:00 PM", capacity: 10},
#   {date: "2018-5-28", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-28", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-28", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-28", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-28", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-28", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-28", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-28", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-29", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-29", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-29", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-29", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-29", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-29", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-29", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-29", time: "7:00 PM", capacity: 10},
#   {date: "2018-5-30", time: "3:00 PM", capacity: 10},
#   {date: "2018-5-30", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-30", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-30", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-30", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-30", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-30", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-30", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-30", time: "7:00 PM", capacity: 10},  
#   {date: "2018-5-31", time: "3:30 PM", capacity: 10},
#   {date: "2018-5-31", time: "4:00 PM", capacity: 10},
#   {date: "2018-5-31", time: "4:30 PM", capacity: 10},
#   {date: "2018-5-31", time: "5:00 PM", capacity: 10},
#   {date: "2018-5-31", time: "5:30 PM", capacity: 10},
#   {date: "2018-5-31", time: "6:00 PM", capacity: 10},
#   {date: "2018-5-31", time: "6:30 PM", capacity: 10},
#   {date: "2018-5-31", time: "7:00 PM", capacity: 10}, 
#   {date: "2018-6-2", time: "10:00 PM", capacity: 10},
#   {date: "2018-6-2", time: "10:30 PM", capacity: 10},
#   {date: "2018-6-2", time: "11:00 PM", capacity: 10},
#   {date: "2018-6-2", time: "11:30 PM", capacity: 10},
#   {date: "2018-6-2", time: "12:00 PM", capacity: 10}, 
#   {date: "2018-6-3", time: "10:00 PM", capacity: 10},
#   {date: "2018-6-3", time: "10:30 PM", capacity: 10},
#   {date: "2018-6-3", time: "11:00 PM", capacity: 10},
#   {date: "2018-6-3", time: "11:30 PM", capacity: 10},
#   {date: "2018-6-3", time: "12:00 PM", capacity: 10},
#   ])