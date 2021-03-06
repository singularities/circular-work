module Page
  class Home
    include Capybara::DSL

    cattr_accessor :path

    self.path = '/home'

    def new_organization_button
      find_button 'Register new organization'
    end

    def visit_new_organization
      new_organization_button.click
    end

    def visit_view_more
      click_link 'View more'
    end
  end
end
