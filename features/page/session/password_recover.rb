module Page
  module Session
    class PasswordRecover
      include Capybara::DSL
      include Capybara::RSpecMatchers

      attr_accessor :new_password

      class << self
        def path_for_token token
          current_host =
            Capybara.app_host ||
            "http://#{ Capybara.current_session.server.host }:#{ Capybara.current_session.server.port }"

          puts "/users/password/edit?config=default&#{ URI.encode_www_form redirect_url: current_host }%2Fecho.json&reset_password_token=#{ token }"
          "/users/password/edit?config=default&#{ URI.encode_www_form redirect_url: current_host }%2Fecho.json&reset_password_token=#{ token }"
        end
      end

      def set_new_password_and_update
        self.new_password = Faker::Internet.password

        fill_in 'Password', with: new_password

        click_button 'Set new password'
      end
    end
  end
end
