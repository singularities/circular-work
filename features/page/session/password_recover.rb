module Page
  module Session
    class PasswordRecover
      include Capybara::DSL
      include Capybara::RSpecMatchers

      attr_accessor :new_password

      class << self
        def path_for_token token
          host = Capybara.current_session.server.host
          port = Capybara.current_session.server.port

          "/users/password/edit?config=default&redirect_url=http%3A%2F%2F#{ host }%3A#{ port }%2Fecho.json&reset_password_token=#{ token }"
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
