Feature: Login
  Background:
    Given there is a User:
      | Email           | Password |
      | bob@example.com | password |

  Scenario: Logging In
    Given I sign in as:
      | Email           | Password |
      | bob@example.com | password |
    Then I should see "Sign Out"

  Scenario: Entering the wrong password
    Given I sign in as:
      | Email           | Password |
      | bob@example.com | foobar |
    Then I should see "Incorrect email or password"
