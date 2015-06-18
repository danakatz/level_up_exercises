Feature: The bomb can be activated with an activation code.
In order to activate the bomb
A supervillain
Can input an activation code through the interface.

  Scenario: Activate the bomb
    Given the bomb has been configured with default activation codes
    When the user inputs the default activation code
    Then the status indicator should say "This bomb is ACTIVE"

  Scenario: Input the wrong activation code
    Given the bomb has been configured with default activation codes
    When the user inputs an incorrect activation code
    Then the status indicator should say "This bomb is INACTIVE"

  Scenario: Attempt to activate an already active bomb
    Given the bomb is active
    When the user inputs the default activation code
    Then the status indicator should say "This bomb is ACTIVE"
