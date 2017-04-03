@javascript
Feature: User sessions
  In order to interact with the app
  I want to be able to login
  (register, recover password soon)

Scenario: Login
  Given I am in the home page
  And I click the login button
  When I login with pepe credentials
  Then I should be at the home page
  And I should be logged in
