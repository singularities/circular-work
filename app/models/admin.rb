class Admin < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  after_create :send_email

  private

  def send_email
    UserMailer.admin(self).deliver_now
  end
end
