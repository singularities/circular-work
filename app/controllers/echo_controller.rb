# Hack to redirection in DeviseTokenAuth::PasswordController#edit
class EchoController < ApplicationController
  def show
    json = {}

    %i{ client_id expiry reset_password token uid }.each do |param|
      json[param] = params[param]
    end

    render json: json
  end
end
