module Page
  module Session
    class PasswordForgotten
      include Capybara::DSL
      include Capybara::RSpecMatchers

      def click_forgot_link
        click_link 'Forgot your password?'
      end

      def recover email
        fill_in 'Email', with: email

        click_button 'Send me recovery email'
      end
    end
  end
end
