Feature: The bomb can be configured with custom activation and deactivation codes.
In order to customize the bomb
A supervillain
Can change the activation and deactivation codes on boot.

  Scenario: User does not provide a custom activation code
    Given the configure page is visible
    When the user leaves the activation code blank
      And the user inputs the default activation code
    Then the status indicator should say "This bomb is ACTIVE"

  Scenario: User does not provide a custom deactivation code
    Given the configure page is visible
    When the user leaves the deactivation code blank
      And the user inputs the default deactivation code
    Then the status indicator should say "This bomb is INACTIVE"

  Scenario: User fills in a new activation code 
    Given the configure page is visible
    When the user submits a new activation code
      And the user inputs the new activation code
    Then the status indicator should say "This bomb is ACTIVE"

  Scenario: User fills in a new deactivation code 
    Given the configure page is visible
    When the user submits a new deactivation code
      And the user inputs the new deactivation code
    Then the status indicator should say "This bomb is INACTIVE"


    

