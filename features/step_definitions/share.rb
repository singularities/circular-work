Given("I am in the share page") do
  visit Page::Share.path
end

When("I add a new invite email and send") do
  share_page.invite
end

Then("I should see the new email message") do
  expect(page).to have_content(share_page.invited_message)
end

Then("I should have created a new user") do
  expect(User.find_by(email: share_page.new_invited_email)).to be_present
end
