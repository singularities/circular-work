class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :tasks
  has_many :groups
  has_many :admin_emails
end
