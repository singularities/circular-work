require 'rails_helper'

class AuthenticationTestController < ApplicationController
end

describe 'Authorization by token', type: :controller do
  fixtures :users

  controller(AuthenticationTestController) do
    before_action :authenticate_user_from_token!
    before_action :authenticate_user!

    def index
      render plain: "ok"
    end
  end


  let(:token) { nil }
  let(:email) { nil }
  let(:authorization) do
    "Token token=\"#{ token }\", email=\"#{ email }\""
  end
  let(:user) do
    users(:pepe).tap do |user|
      user.update_attribute(:authentication_token, 'tOken')
    end
  end

  before do
    @request.headers["HTTP_AUTHORIZATION"] = authorization
    get :index, format: :json
  end

  describe 'when the user token is not present' do
    let(:token) { nil }
    let(:email) { user.email }

    it 'returns a 401 respose' do
      expect(response.code).to eq "401"
    end
  end

  describe 'when the user email is not present' do
    let(:token) { user.authentication_token }
    let(:email) { nil }

    it 'returns a 401 respose' do
      expect(response.code).to eq "401"
    end
  end

  describe 'when the user token is invalid' do
    let(:token) { user.authentication_token + "NOP!" }
    let(:email) { user.email }

    it 'returns a 401 respose' do
      expect(response.code).to eq "401"
    end
  end

  describe 'when the user email is invalid' do
    let(:token) { user.authentication_token }
    let(:email) { user.email + ".nop" }

    it 'returns a 401 respose' do
      expect(response.code).to eq "401"
    end
  end

  describe 'when the user email and token are valid' do
    let(:token) { user.authentication_token }
    let(:email) { user.email }

    it 'returns a 200 respose' do
      expect(response).to be_success
    end
  end
end
