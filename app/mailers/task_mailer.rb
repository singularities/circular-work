class TaskMailer < ApplicationMailer
  def notification task

    @body = task.parsed_notification_body

    mail to: task.notification_to,
         cc: task.notification_cc,
         subject: task.parsed_notification_subject
  end
end
