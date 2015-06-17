Feature: The bomb has an interface which displays bomb status and accepts inputs.
In order to control the bomb through a web interface
A supervillain
Should be able to see and update the bomb's status.

  Scenario Outline: Visit the bomb interface page
    Given the bomb is <status>
    Then the status indicator should say "This bomb is <display>"

    Examples:
      |   status   |   display    |
      |   active   |    ACTIVE    |
      |  inactive  |   INACTIVE   |
