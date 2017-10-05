Given(/^I login with (\w+) credentials$/) do |user|
  @login_page ||= Page::Session::Login.new

  fixture = users(user.to_sym)

  @email = fixture.email
  # FIXME get password from fixture
  # current error:
  # table "users" has no column named "password". (ActiveRecord::Fixture::FixtureError)
  @password = 'pepepepe'

  @login_page.login_with_credentials @email, @password
end

Then(/^I should see the login page$/) do
  expect(page).to have_current_path(Page::Session::Login.path)
end
