Feature: Sign Out
  Scenario: Signing Out
    Given I'm signed in
    And I click "Sign Out"
    Then I should see "Sign Up"
