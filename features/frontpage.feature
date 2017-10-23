@javascript
Feature: Landing in the frontpage

@logs_in
Scenario: View my tasks
  Given I am in the front page
  When I click in the view tasks button
  And I login with pepe credentials
  Then I should see my tasks
