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


@del_env
Scenario: Deleting environments
  Given I log in
  And I add new environments:
    | STG |
    | PROD |
  And environments have been added
  When I delete environments
  Then environments are successfully deleted

@del_all_env
Scenario: Deleting all environments
  Given I log in
  When I delete all environments
  Then all environments are deleted
f48d3cf0-e446-11e7-8bcd-5d3e2d5d7554
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
