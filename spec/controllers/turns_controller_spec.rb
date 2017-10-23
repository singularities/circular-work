require 'rails_helper'

RSpec.describe TurnsController, type: :controller do
  fixtures :all

  describe '#show' do
    let(:turn) { turns(:weekly_1) }
    let(:turn_position) { "\"position\":#{ turn.position }"}
    let(:params) { { id: turn.id } }
    let(:response) { get :show, params: params }

    before { turn.organization.refresh_token }

    context 'when it is not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end
    end

    context "when logged in as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes turn position" do
        expect(response.body).to include(turn_position)
      end
    end

    context "when logged in as member" do
      before { login_user users(:lola) }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes turn position" do
        expect(response.body).to include(turn_position)
      end
    end

    context "when logged in as external user" do
      before { login_user users(:maria) }

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not include turn position" do
        expect(response.body).not_to include(turn_position)
      end
    end

    context "when requesting with organization token" do

      let(:params) {
        {
          id: turn.id,
          token: turn.organization.token
        }
      }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes turn position" do
        expect(response.body).to include(turn_position)
      end
    end

    context "when requesting with a different token" do

      let(:params) {
        {
          id: turn.id,
          token: SecureRandom.hex
        }
      }

      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it "does not include turn position" do
        expect(response.body).not_to include(turn_position)
      end
    end
  end

  describe '#create' do
    let(:task) { tasks(:weekly) }
    let(:response) { post :create, params: turn_data }

    let(:turn_data) do
      {
        data: {
          relationships: {
            task: {
              data: {
                type: 'tasks',
                id: task.id
              }
            }
          }
        }
      }
    end

    context "when not authenticated" do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it "does not save the record" do
        expect { response }.not_to change { Turn.count }
      end
    end

    context "when logged in as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "saves the record" do
        expect { response }.to change { Turn.count }
      end
    end

    context "when logged as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not save the record" do
        expect { response }.not_to change { Turn.count }
      end
    end
  end

  describe '#update' do
    let(:turn) { turns(:weekly_1) }
    let(:response) { patch :update, params: turn_data.merge(id: turn.id) }
    let(:old_position) { turn.position }
    let(:new_position) { 2 }

    let(:turn_data) do
      {
        data: {
          attributes: {
            position: new_position
          }
        }
      }
    end

    context "when not authenticated" do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it "does not save the record" do
        response

        expect(Turn.find(turn.id).position).to eq old_position
      end
    end

    context "when logged in as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "saves the record" do
        response

        expect(Turn.find(turn.id).position).to eq new_position
      end
    end

    context "when logged as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not save the record" do
        response

        expect(Turn.find(turn.id).position).to eq old_position
      end
    end
  end

  describe '#destroy' do
    let(:turn) { turns(:weekly_1) }
    let(:response) { delete :destroy, params: { id: turn.id } }

    context "when not authenticated" do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it "does not delete the record" do
        response

        expect(Turn.find_by(id: turn.id)).not_to be nil
      end
    end

    context "when logged in as admin" do
      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "deletes the record" do
        response

        expect(Turn.find_by(id: turn.id)).to be nil
      end
    end

    context "when logged as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not delete the record" do
        response

        expect(Turn.find_by(id: turn.id)).not_to be nil
      end
    end
  end
end
