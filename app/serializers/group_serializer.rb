class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :emails

  belongs_to :organization
  has_many :tasks
end
