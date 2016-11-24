# Preview all emails at http://localhost:3000/rails/mailers/task_mailer
class TaskMailerPreview < ActionMailer::Preview
  def with_turns
    TaskMailer.notification(Task.weekly.first)
  end

  def without_turns
    TaskMailer.notification(Task.monthly.first)
  end
end
