class Organization < ApplicationRecord
  validates_presence_of :name

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :admins, dependent: :destroy
  has_many :admin_users, through: :admins, source: :user
  has_many :tasks, dependent: :destroy
  has_many :groups, dependent: :destroy

  after_create :add_author_as_admin

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

  private

  def add_author_as_admin
    self.admin_users << author
  end
end
