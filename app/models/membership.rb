class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_one :organization, through: :group

  after_create :send_email

  private

  def send_email
    UserMailer.member(self).deliver_now
  end
end
