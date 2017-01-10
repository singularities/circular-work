class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :emails

  belongs_to :organization
end
