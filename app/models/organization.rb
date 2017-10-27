class Organization < ApplicationRecord
  attr_accessor :current_admin

  validates_presence_of :name

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :admins,
           dependent: :destroy
  has_many :admin_users,
           through: :admins,
           source: :user,
           before_remove: :check_not_empty_admins
  has_many :tasks, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :users, through: :groups

  after_create :add_author_as_admin,
               :refresh_token

  scope :with_admin, ->(user) {
    joins(:admin_users).where(users: { id: user.id })
  }

  scope :with_member, ->(user) {
    joins(:users).where(users: { id: user.id })
  }

  scope :for, ->(user) {
    where(id: with_admin(user).pluck(:id) | with_member(user).pluck(:id))
  }

  def admin_emails
    admin_users.pluck(:email)
  end

  def admin_emails= list
    # Add new emails
    (list - admin_emails).each do |newEmail|
      admin_users << User.find_or_create_by!(email: newEmail)
    end

    # Remove old emails
    (admin_emails - list).each do |oldEmail|
      admin_users.destroy admin_users.find_by(email: oldEmail)
    end
  end

  # Let authenticate with two different methods
  # user or token
  def shows_to? user: nil, token: nil
    authenticates_user?(user) ||
      authenticates_token?(token)
  end

  def refresh_token
    update_column :token, Devise.friendly_token
  end

  private

  def add_author_as_admin
    self.admin_users << author
  end

  def check_not_empty_admins user
    if admin_users.count == 1 && admin_users.include?(user)
      errors.add(:admin_users, "can't be blank")
      raise ActiveRecord::RecordInvalid, self
    end
  end

  def authenticates_user? user
    user &&
      (admin_users | users).include?(user)
  end

  def authenticates_token? token
    token &&
      self.token == token
  end

end
