Feature: Login
  Scenario: Logging In
    Given there is a User:
      | Email           | Password |
      | bob@example.com | password |
    And I login as:
      | Email           | Password |
      | bob@example.com | password |
    Then I should be logged in
