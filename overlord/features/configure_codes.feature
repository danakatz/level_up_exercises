Feature: The bomb can be configured with custom activation and deactivation codes.
In order to customize the bomb
A supervillain
Can change the activation and deactivation codes.

  Scenario: Configure the activation code
    Given a new bomb
    When a user sets a new activation code
    Then the bomb should have the new activation code

  Scenario: Set the activation code to nothing
    Given a new bomb
    When a user sets the activation code to nil
    Then the bomb should keep its original activation code

  Scenario: Configure the deactivation code
    Given a new bomb
    When a user sets a new deactivation code
    Then the bomb should have the new deactivation code

  Scenario: Set the deactivation code to nothing
    Given a new bomb
    When a user sets the deactivation code to nil
    Then the bomb should keep its original deactivation code
