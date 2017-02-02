require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  fixtures :all

  describe '#index' do
    context "when it is not authenticated" do

      before { get :index }

      it 'returns an unauthenticated response' do
        pending "Allowing access to task until we implement task admins"

        expect(response.code).to eq "401"
        expect(response.location).to eq "http://test.host/users/sign_in"
      end
    end

    context "when authenticated" do
      before { login_user }
      before { get :index }

      it "responds successfully" do
        expect(response).to be_success
      end
    end
  end

  describe '#create' do
    let(:response) { post :create, params: task_data }
    let(:task_data) do
      {
        data: {
          attributes: {
            title:      "Limpieza",
            recurrence: "2"
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

    context 'when it is not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.code).to eq "401"
      end
    end

    context 'when the data is invalid' do
      before { login_user }

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

      it "responds unsuccessfully" do
        expect(response).not_to be_success
      end

      it 'returns a 422 status' do
        expect(response.status).to be 422
      end

      it 'does not create the task' do
        expect(Task.find_by(title: "Super Limpieza")).to be nil
      end
    end

    context 'when the task is valid' do
      before { login_user }

      context 'with only required parameters' do
        it "responds successfully" do
          expect(response).to be_success
        end

        it 'creates the task' do
          response
          expect(Task.find_by(title: "Limpieza")).not_to be nil
        end
      end
    end

    context 'when the data is uses dashes in they keys' do
      before { login_user }

      let(:task_data) do
        {
          data: {
            attributes: {
              :title              => "Super-Limpieza",
              :recurrence         => "2",
              :"recurrence-match" => "1 5"
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

      it 'creates the task' do
        response

        expect(Task.find_by(recurrence_match: "1 5").title)
          .to eql "Super-Limpieza"
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

    context "when authenticated" do

      before { login_user }

      let(:response) { patch :update, params: task_data.merge(id: task.id) }

      it "responds successfully" do
        response

        expect(response).to be_success
      end

      it 'updates the task' do
        response

        expect(task.reload.title).to eql("Limpieza actualizada")
      end
    end
  end

  describe '#destroy' do
    let(:task) { tasks(:weekly) }

    let(:response) { delete :destroy, params: { id: task.id } }

    context "when authenticated" do

      before { login_user }


      it "responds successfully" do
        response

        expect(response).to be_success
      end

      it 'destroys the task' do
        response

        expect(Task.find_by(id: task.id)).to be nil
      end
    end
  end
end
