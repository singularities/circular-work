Given(/^I am in the front page$/) do
  visit Page::Front.path
end

When(/^I click in the view tasks button$/) do
  front_page.visit_task_list
end

When(/^I click in the new organization button$/) do
  front_page.visit_create_item
end
