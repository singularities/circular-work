class Organization < ApplicationRecord
  validates_presence_of :name

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :admins
  has_many :admin_users, through: :admins, source: :user
  has_many :tasks
  has_many :groups

  after_create :add_author_as_admin

  private

  def add_author_as_admin
    self.admin_users << author
  end
end
