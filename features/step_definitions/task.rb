Given("I am in the task page with token") do
  @task = tasks(:weekly)
  @task.organization.refresh_token
  token = @task.organization.token

  visit task_path(@task, token: token)
end

Given("I am in the task page with expired token") do
  @task = tasks(:weekly)

  visit task_path(@task, token: SecureRandom.hex)
end

Then(/^I should see my tasks$/) do
  expect(task_list_page.element).to be_visible
end

Then("I should see the task title") do
  expect(page).to have_content(@task.title)
end

Then("I should see the task turns") do
  expect(page).to have_content(@task.turns.first.responsibles.first)
end

Then("I should see the task organization") do
  expect(page).to have_content(@task.organization.name)
end
