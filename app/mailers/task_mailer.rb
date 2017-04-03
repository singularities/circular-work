class TaskMailer < ApplicationMailer
  def notification task
    headers 'reply-to' => task.notification_reply_to

    @body = task.parsed_notification_body

    mail to: task.notification_to,
         cc: task.notification_cc,
         subject: task.parsed_notification_subject
  end
end
