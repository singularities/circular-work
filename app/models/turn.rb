class Turn < ApplicationRecord
  belongs_to :task

  has_many :responsibilities, dependent: :destroy
  has_many :groups, through: :responsibilities
  has_many :users, through: :groups

  acts_as_list scope: :task

  def responsibles
    groups.map(&:name)
  end

  def emails
    users.map(&:email)
  end

end
