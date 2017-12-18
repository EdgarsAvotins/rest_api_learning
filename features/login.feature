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


@delete_env
Scenario: Deleting environments
  Given I log in
  And I add new environments:
    | STG4 |
    | PROD4 |
  And environments have been added
  When I delete environments
  Then environments are successfully deleted
