class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    data = {
      token: self.resource.authentication_token,
      email: self.resource.email
    }
    render json: data, status: 201
  end
end
