@javascript
Feature: Access user organization

@logs_in
Scenario: User accesses from frontpage
  Given I am in the front page
  When I click in the view tasks button
  And I login with lola credentials
  Then I should see my organization
  And I click the organization link
  And I see my organization details
  But I don't see the organization edit button


@logs_in
Scenario: Admin accesses from frontpage
  Given I am in the front page
  When I click in the view tasks button
  And I login with pepe credentials
  Then I should see my organization
  And I click the organization link
  And I see my organization details
  But I see the organization edit button
