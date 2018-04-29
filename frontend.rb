require "unirest"

@signin = false
@admin = false

def login
  response = Unirest.post(
    "http://localhost:3000/user_token",
    parameters: {
      auth: {
        # email: email,
        # password: password
        email: "debbie@email.com",
        password: "password"
      }
    }
  )
  # Save the JSON web token from the response
  jwt = response.body["jwt"]
  if jwt
    @signin = true
    @id = response.body["user"]["id"]
    @name = response.body["user"]["first_name"]
    @account_id = response.body["user"]["account_id"]
    @admin = response.body["user"]["admin"]
  end
  # Include the jwt in the headers of any future web requests
  Unirest.default_header("Authorization", "Bearer #{jwt}")
end

def create_user
  params = {}
  print "Enter first name: "
  params[:first_name] = gets.chomp
  print "Enter last name: "
  params[:last_name] = gets.chomp
  print "Enter email: "
  params[:email] = gets.chomp 
  print "Relationship to student: "
  params[:relationship] = gets.chomp
  print "Enter password: "
  params[:password] = gets.chomp
  print "Enter password again: "
  params[:password_confirmation] = gets.chomp

  # Assign account or create new account
  puts "[1] to add user to existing account"
  puts "[2] to create new account"
  entry = gets.chomp
  if entry == "1"
    print "Enter account name: "
    params[:account_name] = gets.chomp
  elsif entry == "2"
    print "Please enter new account name (usually family last name): "
    params[:account_name] = gets.chomp
  end

  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  body = response.body
  puts JSON.pretty_generate(body)
  puts
  print "[Enter] to Continue ('q' to Quit): "
  gets.chomp
end

def view_account
  response = Unirest.get("http://localhost:3000/v1/accounts/#{@account_id}")
  users = response.body["users"]
  students = response.body["students"]
  puts
  puts "Account: " + response.body["name"]
  puts
  puts "Students: "
  students.each do |student|
    puts student
  end
  puts
  puts "Users: "
  users.each do |user| 
    puts "Name: #{user["first_name"]} #{user["last_name"]}"
    puts "Relationship: #{user["relationship"]}"
    puts
  end
  print "[Any Key] To Continue"
  gets.chomp
end

def view_sessions
  response = Unirest.get("http://localhost:3000/v1/bookings")
  puts JSON.pretty_generate(response.body)
  print "[Any Key] To Continue"
  gets.chomp
end

def book_session
  params = {}
  print "Student Name: "
  params[:student] = gets.chomp
  print "Date (format: 2018-12-31): "
  params[:date] = "2018-04-19"
  print "Time (format: 3:30 PM): "
  params[:time] = "3:30 PM"
  response = Unirest.post("http://localhost:3000/v1/bookings", parameters: params)
  puts JSON.pretty_generate(response.body)
  print "[Any Key] to Continue"
  gets.chomp
end

while true
  
  if @signin == false
    system "clear"
    puts "Welcome to TimeIn!"
    puts "[1] to login"
    puts "[2] to create a new user"
    
    print "Entry: "
    entry = gets.chomp
    if entry == "1"
      login
    elsif entry == "2"
      create_user
    end
  end

  if @signin == true # && @admin == false
    system "clear"
    puts "*** Welcome #{@name} ***"
    puts
    puts "[1] To view account"
    puts "[2] To view booked sessions"
    puts "[3] To book a session"
    print "Entry: "
    entry = gets.chomp

    if entry == "1"
      view_account
    elsif entry == "2"
      view_sessions
    elsif entry == "3"
      book_session
    end
  end
end