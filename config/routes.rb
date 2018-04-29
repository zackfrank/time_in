Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    get "/accounts" => "accounts#index"
    post "/accounts" => "accounts#create"
    patch "/accounts/:id" => "accounts#update"
    get "/accounts/:id" => "accounts#show"
    delete "/accounts/:id" => "accounts#destroy"

    get "/users" => "users#index"
    post "/users" => "users#create"
    patch "/users/:id" => "users#update"
    get "/users/:id" => "users#show"
    delete "/users/:id" => "users#destroy"

    get "/students" => "students#index"
    post "/students" => "students#create"
    patch "/students/:id" => "students#update"
    get "/students/:id" => "students#show"
    delete "/students/:id" => "students#destroy"

    get "/attendance_records" => "attendance_records#index"
    post "/attendance_records" => "attendance_records#create"
    patch "/attendance_records/:id" => "attendance_records#update"
    get "/attendance_records/:id" => "attendance_records#show"
    delete "/attendance_records/:id" => "attendance_records#destroy"

    get "/bookings" => "bookings#index"
    post "/bookings" => "bookings#create"
    patch "/bookings/:id" => "bookings#update"
    get "/bookings/:id" => "bookings#show"
    delete "/bookings/:id" => "bookings#destroy"    
  end
end
