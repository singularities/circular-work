module Page
  class Front
    include Capybara::DSL

    cattr_accessor :path

    self.path = '/'

    def task_list
      find '.action-list'
    end

    def visit_task_list
      task_list.click_link
    end

    def create_item
      find '.action-create'
    end

    def visit_create_item
      create_item.click_link
    end
  end
end
