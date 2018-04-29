class UserTokenController < Knock::AuthTokenController
  def create
    email = request.params["auth"] && request.params["auth"]["email"]
    user = User.find_by(email: email)
    body = {
      jwt: auth_token.token,
      user: user.as_json,
      admin: user.account.admin 
    }
    render json: body, status: :created
  end
end
