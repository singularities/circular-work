class TurnSerializer < ActiveModel::Serializer
  attributes :id

  has_many :groups
end
