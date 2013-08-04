Feature: n+1 query insight
  Background:
    Given I'm signed in
    And I have an app with an n+1 query

  Scenario: Viewing a source with a recent n+1 query
    When I view the source of the n+1 query
    Then I should see "pattern of an n+1 query"

  Scenario: Viewing a request with an n+1 query
    When I view the request of the n+1 query
    Then I should see "Detected an n+1 query"

  Scenario: Viewing the n+1 query insight
    When I view the n+1 query insight
    Then I should see "This may be an n+1 query"
