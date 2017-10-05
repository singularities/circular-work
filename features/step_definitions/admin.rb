When(/^I click in the edit admins button$/) do
  admin_page.click_edit_admins
end

When(/^I add a new admin email$/) do
  admin_page.add_new_admin_email
end

Then(/^I should see the new admin email in the admin list$/) do
  expect(page).to have_content(admin_page.new_admin_email)
end
