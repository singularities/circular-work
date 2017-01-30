Given(/^an organization named "([^"]*)"$/) do |name|
  @organization_page = Page::Organization.new

  @organization_page.create(name)
end
