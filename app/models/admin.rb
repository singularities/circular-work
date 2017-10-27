class Admin < ApplicationRecord
  attr_accessor :skip_email

  belongs_to :organization
  belongs_to :user

  after_create :send_email, unless: Proc.new { |admin| admin.skip_email }

  private

  def send_email
    UserMailer.admin(self).deliver_now
  end
end
