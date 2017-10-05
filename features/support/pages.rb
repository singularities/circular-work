# Access to instances of all the pages
module PageAccess

  pages_folder = File.join(Rails.root, 'features', 'page')
  pages = Dir[File.join(pages_folder, '**/*.rb')].map { |file|
    # strip pages fonder and .rb extension
    # get only the file name
    file[(pages_folder.length + 1)..-4]
  }

  @pages_cache = {}

  pages.each do |page|
    method_name = page.gsub('/', '_') + '_page'

    define_method(method_name) do
      instance_variable_get("@_#{ method_name }") ||
      instance_variable_set("@_#{ method_name }", ('Page::' + page.classify).constantize.new)
    end
  end
end

World(PageAccess)
