module Page
  class Organization
    include Capybara::DSL

    def create name
      visit '/home'

      new_organization.click

      self.name = name

      create_btn.click
    end

    def new_organization
      find_button 'Create new organization'
    end

    def name= value
      fill_in 'Name', with: value
    end

    def create_btn
      find_button 'Create'
    end
  end
end
