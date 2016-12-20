require 'rails_helper'

RSpec.describe Task::Notification, type: :model do

  describe "when asking for parsed body" do
    describe "when the task is empty" do
      before do
        @task = Task.new
      end

      describe "and it has an empty turn" do
        before do
          @task.turns.build
        end

        it "should not get error" do
          expect(@task.parsed_notification_body).to be_nil
        end
      end
    end
  end
end
