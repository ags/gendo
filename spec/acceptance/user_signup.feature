Feature: Signing up
  Scenario: signing up as a new user
    When I sign up as:
      | Email           | Password |
      | bob@example.com | password |
    Then I should be logged in
