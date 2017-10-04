class Group < ApplicationRecord
  belongs_to :organization

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :responsibilities, dependent: :destroy
  has_many :turns, through: :responsibilities
  has_many :tasks, through: :turns

  validates_presence_of :name

  def emails
    users.pluck(:email)
  end

  def emails= list
    # Add new emails
    (list - emails).each do |newEmail|
      users << User.find_or_create_by!(email: newEmail)
    end

    # Remove old emails
    (emails - list).each do |oldEmail|
      users.destroy users.find(email: oldEmail)
    end
  end
end
