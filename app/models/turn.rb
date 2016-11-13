class Turn < ApplicationRecord
  belongs_to :task

  has_many :responsibilities
  has_many :groups, through: :responsibilities
  has_many :users, through: :groups

  acts_as_list scope: :task
end
