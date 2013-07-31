Feature: n+1 query insight
  Background:
    Given I'm signed in
    And I have an app with an n+1 query

  Scenario: Viewing a source with a recent n+1 query
    When I view the source of the n+1 query
    Then I should see "You may have a problem with eager loading"

  Scenario: Viewing a transaction with an n+1 query
    When I view the transaction of the n+1 query
    Then I should see "Possible n+1 query"
