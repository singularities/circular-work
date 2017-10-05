class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # This include must be after the devise statement
  include DeviseTokenAuth::Concerns::User

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :turns, through: :groups
  has_many :authored_tasks, class_name: 'Task', foreign_key: 'author_id'
  has_many :authored_organizations, class_name: 'Organization', foreign_key: 'author_id'
  has_many :admins
  has_many :admin_organizations, through: :admins, source: :organization

  before_validation :set_password, on: :create

  private

  # Allow creation of users through groups that will recover their password
  # in the future
  def set_password
    if password.blank?
      self.password = Devise.friendly_token
    end
  end
end
