require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  fixtures :tasks

  describe '#index' do
    before { get :index }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#create' do
    before { post :create, params: task_data }

    context 'with only required parameters' do
      let(:task_data) do
        {
          data: {
            attributes: {
              title:      "Limpieza",
              recurrence: "2"
            }
          }
        }
      end

      it "responds successfully" do
        expect(response).to be_success
      end

      it 'creates the task' do
        expect(Task.find_by(title: "Limpieza")).not_to be nil
      end
    end

    context 'when required parameters are missing' do
      let(:task_data) do
        {
          data: {
            attributes: {
              title:      "Super Limpieza",
              recurrence: nil
            }
          }
        }
      end

      it "responds successfully" do
        expect(response).not_to be_success
      end

      it 'returns a 422 status' do
        expect(response.status).to be 422
      end

      it 'does not create the task' do
        expect(Task.find_by(title: "Super Limpieza")).to be nil
      end
    end
  end

  describe '#show' do
    let(:task) { tasks(:weekly) }
    before     { get :show, params: { id: task.id } }

    it "responds successfully" do
      expect(response).to be_success
    end
  end

  describe '#update' do
    let(:task) { tasks(:weekly) }
    before     { patch :update, params: task_data.merge(id: task.id) }

    let(:task_data) do
      {
        data: {
          attributes: {
            id:         task.id,
            title:      "Limpieza actualizada",
            recurrence: "2"
          }
        }
      }
    end

    it "responds successfully" do
      expect(response).to be_success
    end

    it 'updates the task' do
      expect(task.reload.title).to eql("Limpieza actualizada")
    end
  end

  describe '#destroy' do
    let(:task) { tasks(:weekly) }
    before     { delete :destroy, params: { id: task.id } }

    it "responds successfully" do
      expect(response).to be_success
    end

    it 'destroys the task' do
      expect(Task.find_by(id: task.id)).to be nil
    end
  end
end
