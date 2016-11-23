require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  fixtures :tasks

  describe "when task has turns" do

    let(:task)  { tasks(:weekly) }

    it "should build the email" do
      email = TaskMailer.notification(task)

      expect(email.to).to match_array(task.turns.first.emails)
      expect(email.cc).to include(task.email)
      expect(email.subject).to include(task.turns.first.groups.first.name)
      expect(email.text_part.body.to_s).to include(task.turns.first.groups.first.name)
    end
  end

  describe "when task has no turns" do

    let(:task)  { tasks(:monthly) }

    it "should build the email" do
      email = TaskMailer.notification(task)

      expect(email.to).to include(task.email)
      expect(email.subject).to eq(task.notification_subject)
      expect(email.text_part.body.to_s).to include(task.notification_body)
    end
  end
end
