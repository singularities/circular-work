module Page
  class Home
    include Capybara::DSL

    cattr_accessor :path

    self.path = '/home'

    def login_button
      find_link 'Login'
    end

    def visit_login
      login_button.click
    end
  end
end
