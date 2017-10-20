require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  fixtures :all

  describe '#index' do
    let(:response) { get :index }

    context "when it is not authenticated" do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end
    end

    context "when authenticated as user" do
      before { login_user users(:lola)}

      it "responds successfully" do
        expect(response).to be_success
      end

      it "returns the title task" do
        expect(response.body).to include(tasks(:weekly).title)
      end

      it "does not return the monthly task" do
        expect(response.body).not_to include(tasks(:monthly_with_author_only).title)
      end
    end
  end

  describe '#show' do
    let(:task) { tasks(:weekly) }
    let(:params) { { id: task.id } }
    let(:response) { get :show, params: params }

    before { task.organization.refresh_token }

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

      it "includes task title" do
        expect(response.body).to include(task.title)
      end
    end

    context "when logged in as member" do
      before { login_user users(:lola) }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes task title" do
        expect(response.body).to include(task.title)
      end
    end

    context "when logged in as external user" do
      before { login_user users(:maria) }

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not include task title" do
        expect(response.body).not_to include(task.title)
      end
    end

    context "when requesting with organization token" do

      let(:params) {
        {
          id: task.id,
          token: task.organization.token
        }
      }

      it "responds successfully" do
        expect(response).to be_success
      end

      it "includes task title" do
        expect(response.body).to include(task.title)
      end
    end

    context "when requesting with a different token" do

      let(:params) {
        {
          id: task.id,
          token: SecureRandom.hex
        }
      }

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not include task title" do
        expect(response.body).not_to include(task.title)
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

    context 'when not authenticated' do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end
    end

    context "when authenticated as admin" do
      before { login_user }

      context 'when the data is invalid' do

        let(:task_data) do
          {
            data: {
              attributes: {
                title:      "Super Limpieza",
                recurrence: nil
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

    context "when authenticated as other user" do
      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.status).to be 403
      end

      it "does not create the task" do
        response

        expect(Task.find_by(title: "Limpieza")).to be nil
      end
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

    let(:response) { patch :update, params: task_data.merge(id: task.id) }

    context "when not authenticated" do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it 'does not update the task' do
        response

        expect(task.reload.title).not_to eql("Limpieza actualizada")
      end
    end

    context "when authenticated as admin" do

      before { login_user }

      it "responds successfully" do
        expect(response).to be_success
      end

      it 'updates the task' do
        response

        expect(task.reload.title).to eql("Limpieza actualizada")
      end
    end

    context "when authenticated as other user" do

      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.response_code).to be 403
      end

      it 'does not update the task' do
        response

        expect(task.reload.title).not_to eql("Limpieza actualizada")
      end
    end
  end

  describe '#destroy' do
    let(:task) { tasks(:weekly) }

    let(:response) { delete :destroy, params: { id: task.id } }

    context "when not authenticated" do
      it 'returns an unauthenticated response' do
        expect(response.status).to eq 401
      end

      it 'does not destroy the task' do
        response

        expect(Task.find_by(id: task.id)).not_to be nil
      end
    end

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

    context "when authenticated as other user" do

      before { login_user users(:lola)}

      it "responds forbidden" do
        expect(response.response_code).to be 403
      end

      it 'does not destroy the task' do
        response

        expect(Task.find_by(id: task.id)).not_to be nil
      end
    end
  end
end
