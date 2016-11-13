class TurnSerializer < ActiveModel::Serializer
  attributes :id, :position

  has_many :groups
end
