module Page
  class Home
    include Capybara::DSL

    cattr_accessor :path

    self.path = '/home'
  end
end
