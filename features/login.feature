Feature: Login
  In order to use the secure application
  As a user
  I want to be able to login

  Scenario: Successful login
    Given there is a test user
    And I am on the login page
    When I login with the test user's credentials
    Then I should be on the recipes page

  Scenario: Failed login
    Given there is a test user
    And I am on the login page
    When I login with invalid credentials
    Then I should be on the login page
