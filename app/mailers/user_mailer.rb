class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.admin.subject
  #
  def admin(admin)
    @current_admin_email = admin.organization.current_admin.email
    @new_admin_email = admin.user.email
    @organization = admin.organization

    headers 'reply-to' => @current_admin_email

    mail to: @new_admin_email,
         cc: @current_admin_email,
         subject: I18n.t('user_mailer.admin.subject', organization: @organization.name)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.member.subject
  #
  def member
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
