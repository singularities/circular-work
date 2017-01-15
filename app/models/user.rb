class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :turns, through: :groups
  has_many :authored_tasks, class_name: 'Task', foreign_key: 'author_id'
  has_many :authored_organizations, class_name: 'Organization', foreign_key: 'author_id'

  before_validation :set_password, on: :create
  before_save :set_auth_token

  private

  # Allow creation of users through groups that will recover their password
  # in the future
  def set_password
    if password.blank?
      self.password = Devise.friendly_token
    end
  end

  def set_auth_token
    if self.authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
