Feature: Clockify Project
# Trabajo Práctico 8 - Lippia API Low-code -
  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2
    * define idWorkSpace = 66fc4bdfabb3a15f171f15ca


  @createProject @createProjectRequiredParameter
  Scenario Outline: Create a new project in workspace
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    * define projectName = '<projectName>'
    And body jsons/bodies/addProject.json
    * print 'body'
    When execute method POST
    Then the status code should be 201
    * define projectId = $.id
    Examples:
      | projectName |
      | prueba 66 |

  @getProjectById
  Scenario: getProjectById
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects/6719620a4800084f063360ef
    When execute method GET
    Then the status code should be 200

  @editProject
  Scenario Outline: editProject
    Given call ClokifyTP8.feature@createProject
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{projectId}}
    And header Content-Type = application/json
    * define editName = '<editName>'
    And body jsons/bodies/editProject.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | editName |
      | edit projetc 2|

  @happyPath @createProjectFullParams
  Scenario: createProjectWithFullParameters
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectFullParams.json
    When execute method POST
    Then the status code should be 201
    And response should be $.hourlyRate.amount = 15000
    And response should be $.billable = true
    And response should be $.public = true


  @createProjectWithSomeOptionalParameters
  Scenario: createProjectWithSomeOptionalParameters
    Given call Clockify.feature@GetWorkspaceInfo
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addOptionalName.json
    When execute method POST
    Then the status code should be 201
    And print response
    And response should be $.public = true


  @createProjectWithoutName @parameterMandatory
  Scenario: createProjectWithoutName
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectSinNombre.json
    When execute method POST
    Then the status code should be 400

  @createProjectInvalidParam
  Scenario: createProjectWithInvalidParameter
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectParametroInvalido.json
    When execute method POST
    Then the status code should be 400


  @pruebaNoAutorizado
  Scenario Outline: createProjectWithoutAuthorization
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    * define projectName = '<projectName>'
    * print 'body'
    And body jsons/bodies/addProject.json
    And header x-api-key = NGRhO
    When execute method POST
    Then the status code should be 401

    Examples:
      | projectName |
      | prueba 1955 |


  @pruebaNoEncontrada @getProjectWithInvalidId
  Scenario: getProjectWithInvalidId
    Given endpoint /v1/workspaces/{{idWorkSpace}}/project/5b641568b07987035750505e
    When execute method GET
    Then the status code should be 404
    And response should be $.message = "No static resource v1/workspaces/66fc4bdfabb3a15f171f15ca/project/5b641568b07987035750505e."
    And response should be $.code = 3000

  @createProjectInvalidParam @error400 @prueba1
  Scenario: createProjectWithInvalidParameter
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectParametroInvalido.json
    When execute method POST
    Then the status code should be 400
    And response should be $.message = "Project name has to be between 2 and 250 characters long"





















