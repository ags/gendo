Feature: Signing up
  Scenario: signing up as a new user
    When I sign up as:
      | Email           | Password |
      | bob@example.com | password |
    Then I should see "sign out"

  Scenario: Signing up with invalid details
    When I sign up as:
      | Email           | Password |
      | bob | password |
    Then I should see "Email doesn't look right"
