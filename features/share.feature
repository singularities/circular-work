@javascript
Feature: Share inviting by email

@logs_in
Scenario: Invite someone by email
  Given I am in the share page
  And I login with pepe credentials
  # TODO return to share page after login
  And I am in the share page
  When I add a new invite email and send
  Then I should see the new email message
  And I should have created a new user
