Feature: Apimation

@login
Scenario: Log in Apimation
  When I try to log in Apimation
  Then I get a positive response

@add_env
Scenario: Adding environment
  Given I log in
  When I add new environments:
    | STG  |
    | PROD |
  Then environments have been added

@collection
Scenario: Add collection
  Given I log in
  When I add collection
  Then collection was added successfully

@request
Scenario: Add request to collection
  Given I log in
  And I add collection
  And collection was added successfully
  When I add request to this collection
  Then request was added successfully
