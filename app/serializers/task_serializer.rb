class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :recurrence, :recurrence_match, :email, :notification_subject, :notification_body

  has_many :turns
end
