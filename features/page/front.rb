module Page
  class Front
    include Capybara::DSL

    cattr_accessor :path

    self.path = '/'

    def visit_task_list
      click_link 'View your tasks'
    end

    def visit_create_item
      # Scroll to element
      visit '#participation'

      click_link 'Use it in your organization'
    end
  end
end
