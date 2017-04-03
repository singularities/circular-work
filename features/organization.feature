@javascript
Feature: Creating new organization

Scenario: Login access required from the frontpage
  Given I am in the front page
  When I click in the new organization button
  Then I should see the login page
