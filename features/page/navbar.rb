module Page
  class Navbar
    include Capybara::DSL

    def logged_as_element
      find '.logged-as'
    end

    def logged_email
      logged_as_element.text
    end
  end
end
