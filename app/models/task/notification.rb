class Task
  module Notification
    def notification_to
      turns.first ?
        turns.first.emails :
        notification_email
    end

    def notification_cc
      turns.first ?
      notification_email :
      nil
    end

    def notification_reply_to
      Array(notification_to) |
        Array(notification_cc)
    end

    def parsed_notification_subject
      parse notification_subject
    end

    def parsed_notification_body
      parse notification_body
    end

    private

    def parse text
      return text if turns.empty? || text.nil?

      text.gsub('@responsibles', turns.first.responsibles.join(', '))
    end
  end
end
