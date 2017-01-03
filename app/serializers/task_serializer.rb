class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :recurrence, :recurrence_match, :notification_email, :notification_subject, :notification_body

  belongs_to :organization
  has_many :turns
end
