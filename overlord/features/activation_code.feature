Feature: The bomb can be activated with an activation code.
In order to activate the bomb
A supervillain
Can input an activation code through the interface.

  Scenario: Activate the bomb
    Given the bomb is inactive
    When a user inputs the correct activation code
    Then the bomb should become active
      And the status indicator should say "This bomb is ACTIVE"

  Scenario: Input the wrong activation code
    Given the bomb is inactive
    When a user inputs an incorrect activation code
    Then the bomb should do nothing
      And the status indicator should say "This bomb is INACTIVE"

  Scenario: Attempt to activate an already active bomb
    Given the bomb is active
    When a user inputs a code other than the deactivation code
    Then the bomb should do nothing
      And the status indicator should say "This bomb is ACTIVE"
