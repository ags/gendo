Feature: Sign Out
  Scenario: Signing Out
    Given I'm logged in
    And I click "sign out"
    Then I should see "sign up"
