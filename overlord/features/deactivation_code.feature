Feature: The bomb can be deactivated with an deactivation code.
In order to deactivate the bomb
A supervillain
Can input a deactivation code through the interface.  

  Scenario: Deactivate the bomb
    Given the bomb is active
    When the user inputs the default deactivation code
    Then the status indicator should say "This bomb is INACTIVE"

  Scenario: Input the wrong deactivation code
    Given the bomb is active
    When the user inputs an incorrect deactivation code
    Then the status indicator should say "This bomb is ACTIVE"

  Scenario: Three failed attempts to deactivate the bomb detonates the bomb
    Given the bomb is active
    When the user inputs three consecutive incorrect deactivation codes
    Then the bomb should explode
      