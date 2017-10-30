Then(/^I should be logged in as (\w+)$/) do |user|
  expect(navbar_page.logged_email).to eq(users(user).email)
end

When(/^I click the login button$/) do
  navbar_page.visit_login
end

Then(/^I click the logout button$/) do
  navbar_page.visit_logout
end
