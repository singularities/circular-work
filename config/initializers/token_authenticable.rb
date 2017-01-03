Warden::Strategies.add(:token_authenticatable) do
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def valid?
    request.headers["HTTP_AUTHORIZATION"].present?
  end

  def authenticate!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user       = user_email && User.find_by_email(user_email)
      if user && Devise.secure_compare(user.authentication_token, token)
        request.env['devise.skip_trackable'] = true

        success!(user)
      else
        fail!("Could not authenticate token")
      end
    end
  end
end
