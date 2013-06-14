Feature: Creating an App
  Scenario: Creating a new App
    Given I'm signed in
    When I create a new App named "Shinji"
    Then I should see "Shinji"

  Scenario: Entering an invalid name during App Creation
    Given I'm signed in
    When I create a new App named ""
    Then I should see "Name is too short"
