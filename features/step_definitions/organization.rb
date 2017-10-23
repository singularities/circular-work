Given(/^an organization named "([^"]*)"$/) do |name|
  organization_page.create(name)
end

Given(/^I am in the organization page$/) do
  visit organization_path(organizations(:singularities))
end

Given(/^I am in the organization page with token$/) do
  organizations(:singularities).refresh_token
  token = organizations(:singularities).token

  visit organization_path(organizations(:singularities), token: token)
end

Given(/^I click in the (.*) tab$/) do |tab|
  organization_page.show_tab(tab)
end

When(/^I fill the organization form and submit$/) do
  organization_page.fill_form_and_submit
end

Then(/^I should see the new organization$/) do
  expect(page).to have_content(organization_page.new_organization_name)
end
