module Page
  class Organization
    include Capybara::DSL
    include Capybara::RSpecMatchers

    attr_accessor :new_organization_name

    def create name
      visit '/home'

      new_organization.click

      self.name = name

      create_btn.click
    end

    def fill_form_and_submit
      self.new_organization_name = Faker::Name.name

      page.should have_css(".organization-details-form input", visible: true)

      self.name = new_organization_name

      create_btn.click

      page.should_not have_css(".organization-details-form input", visible: true)
    end

    def show_tab tab
      click_link tab
    end

    def new_organization
      find_button 'Register new organization'
    end

    def name= value
      fill_in 'Name', with: value

      # Wait for the field to be filled
      find_field('Name').value.should have_content(value)
    end

    def create_btn
      find_button 'Register'
    end

    def view_details
      %w{ Tasks Groups Admins }.each do |tab|
        page.should have_content(tab)
      end
    end
  end
end
