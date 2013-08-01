Feature: Send email asynchronously insight
  Background:
    Given I'm signed in
    And I have an app that sent an email in a request

  Scenario: Viewing a source that recently sent an email in a request
    When I view the the source of the request that sent the email
    Then I should see "Looks like you're sending emails in your requests"

  Scenario: Viewing the transaction that sent an email
    When I view the transaction that sent an email
    Then I should see "sending emails"
