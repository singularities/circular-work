class Turn < ApplicationRecord
  belongs_to :task
  has_one :organization, through: :task
  # Note that
  # has_many :admin_users, through: :organization
  # does not work for new (unsaved) records
  has_many :admin_users, through: :task

  has_many :responsibilities, dependent: :destroy
  has_many :groups, through: :responsibilities
  has_many :users, through: :groups

  acts_as_list scope: :task

  def responsibles
    groups.pluck(:name)
  end

  def emails
    users.pluck(:email)
  end

end
