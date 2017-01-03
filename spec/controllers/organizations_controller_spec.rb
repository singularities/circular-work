require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  fixtures :organizations, :users

  describe '#index' do
    before { get :index }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#create' do

    let(:response) { post :create, params: organization_data }

    let(:organization_data) do
      {
        data: {
          attributes: {
            name: "Testing"
          }
        }
      }
    end

    context 'when it is not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.code).to eq "302"
        expect(response.location).to eq "http://test.host/users/sign_in"
      end
    end

    context 'when the data is invalid' do
      before { login_user }

      let(:organization_data) do
        {
          data: {
            attributes: {
              name: nil
            }
          }
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

      context 'with only required parameters' do
        it "responds successfully" do
          expect(response).to be_success
        end

        it 'creates the organization' do
          response

          expect(Organization.find_by(name: "Testing")).not_to be nil
        end
      end
    end
  end

  describe '#show' do
    let(:organization) { organizations(:singularities) }

    before     { get :show, params: { id: organization.id } }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#update' do
    let(:organization) { organizations(:singularities) }

    before { login_user }
    before     { patch :update, params: organization_data.merge(id: organization.id) }

    let(:organization_data) do
      {
        data: {
          attributes: {
            name: 'New Singularties'
          }
        }
      }
    end

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#destroy' do
    let(:organization) { organizations(:singularities) }

    before { login_user }
    before     { delete :destroy, params: { id: organization.id } }

    it "responds successfully" do
      expect(response).to be_success
    end

    it 'destroys the organization' do
      expect(Organization.find_by(id: organization.id)).to be nil
    end
  end
end