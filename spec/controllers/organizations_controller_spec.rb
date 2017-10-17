require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  fixtures :organizations, :users, :admins

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
        expect(response.status).to eq 401
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

    it "includes author email" do
      expect(response.body).to include(organizations(:singularities).author.email)
    end
  end

  describe '#update' do
    let(:organization) { organizations(:singularities) }
    let(:new_name) { 'New Singularities' }

    let(:organization_data) do
      {
        data: {
          attributes: {
            name: new_name
          }
        }
      }
    end

    let(:response) { patch :update, params: organization_data.merge(id: organization.id) }

    context "when logged in as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "updates the organization" do
        response

        expect(Organization.find(organization.id).name).to eq(new_name)
      end
    end

    context "when logged in as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.response_code).to be(403)
      end

      it "does not update the organization" do
        response

        expect(Organization.find(organization.id).name).not_to eq(new_name)
      end
    end
  end

  describe '#destroy' do
    let(:organization) { organizations(:singularities) }
    let(:response) { delete :destroy, params: { id: organization.id } }

    context "when logged in as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it 'destroys the organization' do
        response

        expect(Organization.find_by(id: organization.id)).to be nil
      end
    end

    context "when logged in as other user" do

      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.response_code).to be(403)
      end

      it 'does not destroy the organization' do
        response

        expect(Organization.find_by(id: organization.id)).not_to be nil
      end
    end
  end
end
