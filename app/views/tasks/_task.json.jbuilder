json.extract! task, :id, :title, :description, :recurrence, :recurrence_match, :email, :notification_subject, :notification_body, :created_at, :updated_at
json.url task_url(task, format: :json)