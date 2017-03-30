Given(/^A user with email ([\w@\.]+) and password (\w+)$/) do |email, password|
  @email, @password = email, password
end

Given(/^I login with the credentials$/) do
  @login_page ||= Page::Session::Login.new

  @login_page.login_with_credentials @email, @password
end
