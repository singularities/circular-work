module Investigate
  def edit
    puts '++++++++++++++++++ DeviseTokenAuth::PasswordController'

    puts 'class'
    puts resource_class.inspect

    puts 'token'
    puts resource_params[:reset_password_token]

    u = User.find_by(email: 'atan@as.io')

    puts u.inspect
    puts u.reset_password_token

    super
  end
end

DeviseTokenAuth::PasswordsController.send :prepend, Investigate

module InvestigateModel
  def reset_password_by_token(attributes={})
    puts '+++++++++++++++++ in model'
    puts '+++++++++++++++++ in model'
    puts '+++++++++++++++++ in model'
    puts 'token:'
    puts attributes[:reset_password_token]
    puts 'reset_password_token:'
    rpt = Devise.token_generator.digest(self, :reset_password_token, attributes[:reset_password_token])
    puts rpt.inspect

    puts rec = find_or_initialize_with_error_by(:reset_password_token, rpt)
    puts rec.try(:id)
    puts rec.email
    puts rec.try(:persisted?)
    puts rec.try(:reset_password_period_valid?)

    super(attributes)
  end
end

User.send :extend, InvestigateModel
