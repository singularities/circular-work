require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do

  fixtures :users

  describe '#create' do

    let(:response) { post :create, params: invitation_data }
    let(:email) { Faker::Internet.email }

    let(:invitation_data) do
      {
        email: email
      }
    end

    context 'when it is not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end
    end

    context 'when the data is invalid' do
      before { login_user }

      let(:invitation_data) do
        {
          email: 'not an email'
        }
      end

      it "responds unsuccessfully" do
        expect(response).not_to be_success
      end

      it 'returns a 422 status' do
        expect(response.status).to be 422
      end

    end

    context 'when the data is valid' do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "responds with email" do
        expect(response.body).to include(email)
      end

      it 'creates the invitation' do
        response

        expect(User.find_by(email: email)).not_to be nil
      end
    end
  end
end
