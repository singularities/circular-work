Given(/^I am in the home page$/) do
  visit Page::Home.path
end

Given(/^I click in the home page new organization button$/) do
  home_page.visit_new_organization
end


Then(/^I should be at the home page$/) do
  expect(page).to have_current_path(Page::Home.path)
end
