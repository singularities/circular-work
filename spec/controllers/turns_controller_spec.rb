require 'rails_helper'

RSpec.describe TurnsController, type: :controller do
  fixtures :turns
  fixtures :tasks

  describe '#index' do
    before { get :index }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#create' do
    let(:task) { tasks(:weekly) }
    before { post :create, params: turn_data }

    let(:turn_data) do
      {
        data: {
          attributes: {
            task_id: task.id
          }
        }
      }
    end

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#show' do
    let(:turn) { turns(:weekly_1) }
    before     { get :show, params: { id: turn.id } }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#update' do
    let(:turn) { turns(:weekly_1) }
    before     { patch :update, params: turn_data.merge(id: turn.id) }

    let(:turn_data) do
      {
        data: {
          attributes: {
            task_id: turn.task_id
          }
        }
      }
    end

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#destroy' do
    let(:turn) { turns(:weekly_1) }
    before     { delete :destroy, params: { id: turn.id } }

    it "responds successfully" do
      expect(response).to be_success
    end

    it 'destroys the turn' do
      expect(Turn.find_by(id: turn.id)).to be nil
    end
  end
end
