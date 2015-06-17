Feature: The bomb can be deactivated with an deactivation code.
In order to deactivate the bomb
A supervillain
Can input a deactivation code through the interface.  

  Scenario: Deactivate the bomb
    Given the bomb is active
    When a user inputs the correct deactivation code
    Then the bomb should become inactive
      And the status indicator should say "This bomb is INACTIVE"

  Scenario: Input the wrong deactivation code
    Given the bomb is active
    When a user inputs an incorrect deactivation code
    Then the bomb should do nothing
      And the status indicator should say "This bomb is ACTIVE"
      