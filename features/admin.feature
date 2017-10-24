@javascript
Feature: Organization admins

@logs_in
Scenario: Add a new admin to the organization
  Given I am in the organization page
  And I login with pepe credentials
  # TODO return to organization page after login
  And I am in the organization page
  And I click in the Admins tab
  When I click in the edit admins button
  And I add a new admin email
  Then I should see the new admin email in the admin list
