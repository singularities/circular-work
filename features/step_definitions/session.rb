Given(/^A user (\w+) with email and password/) do |user|
  fixture = users(user.to_sym)
  
  @email = fixture.email
  # FIXME get password from fixture
  # current error:
  # table "users" has no column named "password". (ActiveRecord::Fixture::FixtureError)
  @password = 'pepepepe'
end

Given(/^I login with the credentials$/) do
  @login_page ||= Page::Session::Login.new

  @login_page.login_with_credentials @email, @password
end
