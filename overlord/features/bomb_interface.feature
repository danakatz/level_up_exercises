Feature: The bomb has an interface which displays bomb status and accepts inputs.
In order to control the bomb through a web interface
A supervillain
Should be able to see and update the bomb's status.

  Scenario: Configure the bomb on first visit
    When the user visits the home page for the first time
    Then they should see the configure page

  Scenario: The user can enter custom codes on the configure page
    When the user visits the home page for the first time
    Then there should be a text field for the activation code
      And there should be a text field for the deactivation code

  Scenario: Bomb status is inactive after bomb configuration
    Given the bomb has been configured
    Then the status indicator should say "This bomb is INACTIVE" 
  
  Scenario: The text field to enter codes is visible after bomb configuration
    Given the bomb has been configured
    Then the page should have a text field for entering a code
