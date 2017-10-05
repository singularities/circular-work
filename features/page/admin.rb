module Page
  class Admin
    include Capybara::DSL
    include Capybara::RSpecMatchers

    ADMIN_EMAIL_LABEL = 'Enter admin emails, one per line or separated by commas'

    attr_accessor :new_admin_email

    def click_edit_admins
      click_button 'Edit admins'
    end

    def add_new_admin_email
      self.new_admin_email = Faker::Internet.email

      current_admin = find_field(ADMIN_EMAIL_LABEL).value

      fill_in ADMIN_EMAIL_LABEL, with: "#{ current_admin }, #{ new_admin_email }"

      click_button 'Update'

      page.should_not have_content(ADMIN_EMAIL_LABEL)
    end
  end
end
