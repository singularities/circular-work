Then(/^I should see my tasks$/) do
  expect(task_list_page.element).to be_visible
end
