module Page
  module Session
    class Login
      include Capybara::DSL

      def login_with_credentials email, password
        self.email = email
        self.password = password

        login_button.click
      end

      def email= value
        fill_in 'Email', with: value
      end

      def password= value
        fill_in 'Password', with: value
      end

      def login_button
        find_button 'Login'
      end
    end
  end
end
