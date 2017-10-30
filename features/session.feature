@javascript
Feature: User sessions
  In order to interact with the app
  I want to be able to login and recover password

@logs_in
Scenario: Login
  Given I am in the organization page with token
  And I click the login button
  When I login with pepe credentials
  Then I should be at the home page
  And I should be logged in as pepe

Scenario: Password forgotten
  Given I am in the front page
  And I click in the view tasks button
  And I click in the forgot your password link
  When I introduce atanasio email and click recovery email
  Then I should see atanasio sent recovery email message
  And I should see atanasio recover token

@logs_in
Scenario: Password recovered
  Given I am in the recovery password page for atanasio
  When I set a new password and click update
  Then I should be at the home page
  And I click the logout button
  And I click in the view tasks button
  And I login with new atanasio credentials
  And I should be logged in as atanasio
