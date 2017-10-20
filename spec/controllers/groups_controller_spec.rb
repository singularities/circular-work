require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  fixtures :all

  describe '#show' do
    let(:group) { groups(:pepe_lola) }
    let(:params) { { id: group.id }}
    let(:response) { get :show, params: params }

    before { group.organization.refresh_token }

    context 'when it is not authenticated' do
      it "responds forbidden" do
        expect(response.status).to be 403
      end
    end

    context "when logged in as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes group name" do
        expect(response.body).to include(group.name)
      end
    end

    context "when logged in as member" do
      before { login_user users(:lola) }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes group name" do
        expect(response.body).to include(group.name)
      end
    end

    context "when logged in as external user" do
      before { login_user users(:maria) }

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not include group name" do
        expect(response.body).not_to include(group.name)
      end
    end

    context "when requesting with organization token" do

      let(:params) {
        {
          id: group.id,
          token: group.organization.token
        }
      }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes group name" do
        expect(response.body).to include(group.name)
      end
    end

    context "when requesting with a different token" do

      let(:params) {
        {
          id: group.id,
          token: SecureRandom.hex
        }
      }

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not include group name" do
        expect(response.body).not_to include(group.name)
      end
    end
  end

  describe '#create' do
    let(:response) { post :create, params: group_data }
    let(:group_data) do
      {
        data: {
          attributes: {
            name: "Super grupo"
          },
          relationships: {
            organization: {
              data: {
                id: organizations(:singularities).id,
                type: 'organization'
              }
            }
          }
        }
      }
    end

    context 'when not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it 'does not create the group' do
        response

        expect(Group.find_by(name: "Super Super Grupo")).to be nil
      end
    end

    context "when authenticated as admin" do
      before { login_user }

      context 'with only required parameters' do

        it "responds successfully" do
          expect(response).to be_success
        end

        it 'creates the group' do
          response

          expect(Group.find_by(name: "Super grupo")).not_to be nil
        end
      end

      context 'when required parameters are missing' do
        let(:group_data) do
          {
            data: {
              attributes: {
                not_a_name: "Super Super Grupo"
              },
              relationships: {
                organization: {
                  data: {
                    id: organizations(:singularities).id,
                    type: 'organization'
                  }
                }
              }
            }
          }
        end

        it "does not responds successfully" do
          expect(response).not_to be_success
        end

        it 'returns a 422 status' do
          expect(response.status).to be 422
        end

        it 'does not create the group' do
          response

          expect(Group.find_by(name: "Super Super Grupo")).to be nil
        end
      end
    end

    context "when authenticated as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it 'does not create the group' do
        response

        expect(Group.find_by(name: "Super Super Grupo")).to be nil
      end
    end
  end

  describe '#update' do
    let(:group) { groups(:pepe_lola) }
    let(:response) { patch :update, params: group_data.merge(id: group.id) }
    let(:old_name) { group.name }
    let(:new_name) { "Lola y Pepe updated" }

    let(:group_data) do
      {
        data: {
          attributes: {
            id:   group.id,
            name: new_name
          }
        }
      }
    end

    context 'when not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it 'does not update the group' do
        response

        expect(group.reload.name).not_to eql new_name
      end
    end

    context "when authenticated as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it 'updates the group' do
        response

        expect(group.reload.name).to eql new_name
      end
    end

    context "when authenticated as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it 'does not update the group' do
        response

        expect(group.reload.name).not_to eql new_name
      end
    end
  end

  describe '#destroy' do
    let(:group) { groups(:pepe_lola) }
    let(:response) { delete :destroy, params: { id: group.id } }

    context 'when not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it 'does not destroy the group' do
        response

        expect(Group.find_by(id: group.id)).not_to be nil
      end
    end

    context "when authenticated as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it 'destroys the group' do
        response

        expect(Group.find_by(id: group.id)).to be nil
      end
    end

    context "when authenticated as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it 'does not destroy the group' do
        response

        expect(Group.find_by(id: group.id)).not_to be nil
      end
    end
  end
end
