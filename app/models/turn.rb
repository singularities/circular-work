class Turn < ApplicationRecord
  belongs_to :task

  has_many :responsibilities
  has_many :groups, through: :responsibilities
  has_many :users, through: :groups
end
