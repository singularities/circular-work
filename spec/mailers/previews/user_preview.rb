# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/admin
  def admin
    admin = Admin.first
    admin.organization.current_admin = admin.organization.admin_users.first

    UserMailer.admin admin
  end

  # Preview this email at http://localhost:3000/rails/mailers/user/member
  def member
    UserMailer.member Membership.first
  end

end
