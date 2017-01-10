require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  fixtures :groups, :organizations

  describe '#index' do
    before { get :index }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#create' do
    before { post :create, params: group_data }

    context 'with only required parameters' do
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

      it "responds successfully" do
        expect(response).to be_success
      end

      it 'creates the group' do
        expect(Group.find_by(name: "Super grupo")).not_to be nil
      end
    end

    context 'when required parameters are missing' do
      let(:group_data) do
        {
          data: {
            attributes: {
              not_a_name: "Super Super Grupo"
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
        expect(Group.find_by(name: "Super Super Grupo")).to be nil
      end
    end
  end

  describe '#show' do
    let(:group) { groups(:pepe_lola) }
    before      { get :show, params: { id: group.id } }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#update' do
    let(:group) { groups(:pepe_lola) }
    before      { patch :update, params: group_data.merge(id: group.id) }

    let(:group_data) do
      {
        data: {
          attributes: {
            id:         group.id,
            name:       "Lola y Pepe actualizados"
          }
        }
      }
    end

    it "responds successfully" do
      expect(response).to be_success
    end

    it 'updates the group' do
      expect(group.reload.name).to eql("Lola y Pepe actualizados")
    end
  end

  describe '#destroy' do
    let(:group) { groups(:pepe_lola) }
    before      { delete :destroy, params: { id: group.id } }

    it "responds successfully" do
      expect(response).to be_success
    end

    it 'destroys the group' do
      expect(Group.find_by(id: group.id)).to be nil
    end
  end
end
