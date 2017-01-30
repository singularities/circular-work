module Page
  module Task
    class List
      include Capybara::DSL

      def element
        find '.task-list'
      end
    end
  end
end
