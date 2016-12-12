require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  fixtures :tasks, :responsibilities

  describe "when task has turns" do

    let(:task)  { tasks(:weekly) }
    let(:email) { TaskMailer.notification(task) }

    it 'the email has the valid TO' do
      expect(email.to).to match_array(task.turns.first.emails)
    end

    it 'the email has the valid CC' do
      expect(email.cc).to include(task.notification_email)
    end

    it 'the email has the valid subject' do
      expect(email.subject).to include(task.turns.first.groups.first.name)
    end

    it 'the email has the valid text_part' do
      expect(email.text_part.body.to_s)
        .to include(task.turns.first.groups.first.name)
    end
  end

  describe "when task has no turns" do

    let(:task)  { tasks(:monthly) }
    let(:email) { TaskMailer.notification(task) }

    it 'the email has the valid TO' do
      expect(email.to).to include(task.notification_email)
    end

    it 'the email has the valid subject' do
      expect(email.subject).to eq(task.notification_subject)
    end

    it 'the email has the valid text_part' do
      expect(email.text_part.body.to_s).to include(task.notification_body)
    end
  end
end
