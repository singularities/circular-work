Then(/^I should be logged in$/) do
  @navbar_page ||= Page::Navbar.new

  expect(@navbar_page.logged_email).to eq(@email)
end
