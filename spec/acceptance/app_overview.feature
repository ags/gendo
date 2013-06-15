Feature: App overview
  Scenario: Viewing an App overview
    Given I'm signed in
    And I have an App named "Shinji"
    And the app has Transactions:
      | Controller      | Action | DB Runtime |
      | PostsController | new    | 0.001      |
      | PostsController | new    | 1.23       |
      | PostsController | create | 0.005      |
    And I visit the App overview page
    Then I should see "1.23 ms"
    And I should see "0.005 ms"
    And I should not see "0.001 ms"
