@javascript
Feature: Access task
  In order to see my task information (turns, order...)
  I want to be able to access my task with a token

Scenario: Access task with token
  Given I am in the task page with token
  Then I should see the task title
  And I should see the task turns
  And I should see the task organization
