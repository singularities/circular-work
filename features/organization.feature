@javascript
Feature: Creating new organization

Scenario: Login access required from the frontpage
  Given I am in the front page
  When I click in the new organization button
  Then I should see the login page

Scenario: Access create organization from frontpage
  Given I am in the front page
  And I click in the new organization button
  And I login with pepe credentials
  When I fill the organization form and submit
  Then I should see the new organization
