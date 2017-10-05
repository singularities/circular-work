@javascript
Feature: Organization admins

@logs_in
Scenario: Add a new admin to the organization
  # TODO start from organization page directly
  # when return to current page after login
  # is implemented
  Given I am in the home page
  And I click the login button
  And I login with pepe credentials
  And I am in the organization page
  And I click in the Admins tab
  When I click in the edit admins button
  And I add a new admin email
  Then I should see the new admin email in the admin list
