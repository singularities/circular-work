@javascript
Feature: Landing in the frontpage

Background:
  Given an organization named "Singularities"

Scenario: View my tasks
  Given I am in the front page
  When I click in the view tasks button
  Then I should see my tasks
