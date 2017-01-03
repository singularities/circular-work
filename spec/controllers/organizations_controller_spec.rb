require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  fixtures :organizations

  describe '#index' do
    before { get :index }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#create' do

    before { post :create, params: organization_data }

    let(:organization_data) do
      {
        data: {
          attributes: {
            name: "Testing"
          }
        }
      }
    end

    it "responds successfully" do
      expect(response).to be_success
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

    before     { delete :destroy, params: { id: organization.id } }

    it "responds successfully" do
      expect(response).to be_success
    end

    it 'destroys the organization' do
      expect(Organization.find_by(id: organization.id)).to be nil
    end
  end
end
