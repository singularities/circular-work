module Page
  class Share
    include Capybara::DSL
    include Capybara::RSpecMatchers

    cattr_accessor :path

    self.path = '/share'

    attr_accessor :new_invited_email

    def invite
      self.new_invited_email = Faker::Internet.email

      fill_in 'Email', with: new_invited_email

      click_button 'Send invitation'
    end

    def invited_message
      "Invitation email sent to #{ new_invited_email }"
    end
  end
end
