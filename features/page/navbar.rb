module Page
  class Navbar
    include Capybara::DSL

    def logged_as_element
      find '.logged-as'
    end

    def logged_email
      logged_as_element.text
    end

    def login_button
      find_link 'Login'
    end

    def visit_login
      login_button.click
    end

    def logout_button
      find_link 'Logout'
    end

    def visit_logout
      logout_button.click
    end
  end
end
