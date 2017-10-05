class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :admin_emails

  has_many :tasks
  has_many :groups
end
