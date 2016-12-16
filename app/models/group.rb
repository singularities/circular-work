class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  has_many :responsibilities
  has_many :turns, through: :responsibilities

  validates_presence_of :name

  def emails
    users.map(&:email)
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
