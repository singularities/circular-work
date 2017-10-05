Given(/^an organization named "([^"]*)"$/) do |name|
  organization_page.create(name)
end

When(/^I fill the organization form and submit$/) do
  organization_page.fill_form_and_submit
end

Then(/^I should see the new organization$/) do
  expect(page).to have_content(organization_page.new_organization_name)
end
