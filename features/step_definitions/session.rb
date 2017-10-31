Given(/^I login with (\w+) credentials$/) do |user|
  fixture = users(user.to_sym)

  @email = fixture.email
  # FIXME get password from fixture
  # current error:
  # table "users" has no column named "password". (ActiveRecord::Fixture::FixtureError)
  @password = user * 2

  session_login_page.login_with_credentials @email, @password
end

Then(/^I login with new (\w+) credentials$/) do |user|
  fixture = users(user.to_sym)

  email = fixture.email
  password = session_password_recover_page.new_password

  session_login_page.login_with_credentials email, password
end

Given("I click in the forgot your password link") do
  session_password_forgotten_page.click_forgot_link
end

Given(/I am in the recovery password page for (\w+)/) do |user|
  fixture = users(user)

  token = fixture.send :set_reset_password_token

  puts '++++++++++ In step'
  puts token.inspect

  u = User.find_by(email: fixture.email)
  puts u.inspect
  puts u.reset_password_token

  visit Page::Session::PasswordRecover.path_for_token token
end

When(/I introduce (\w+) email and click recovery email/) do |user|
  fixture = users(user)

  session_password_forgotten_page.recover fixture.email
end

When("I set a new password and click update") do
  session_password_recover_page.set_new_password_and_update
end

Then(/I should see (\w+) sent recovery email message/) do |user|
  fixture = users(user)

  expect(page).to have_content("Un correo electrónico ha sido enviado a '#{fixture.email}' con las instrucciones para restablecer su contraseña.")
end

Then(/I should see (\w+) recover token/) do |user|
  fixture = users(user)
  record = User.find_by(email: fixture.email)

  expect(record.reset_password_token).to be_present
end

Then(/^I should see the login page$/) do
  expect(page).to have_current_path(Page::Session::Login.path)
end
