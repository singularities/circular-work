Given(/^I am in the home page$/) do
  visit Page::Home.path

  @home_page = Page::Home.new
end

When(/^I click the login button$/) do
  @home_page.visit_login
end

Then(/^I should be at the home page$/) do
  expect(page).to have_current_path(Page::Home.path)
end
