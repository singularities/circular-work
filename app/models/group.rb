class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  has_many :responsibilities
  has_many :turns, through: :responsibilities

  validates_presence_of :name
end
