Feature: Sign Out
  Scenario: Signing Out
    Given I'm signed in
    And I click "sign out"
    Then I should see "sign up"
