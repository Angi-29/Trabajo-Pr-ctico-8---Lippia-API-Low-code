Feature: Clockify Project
# Trabajo Práctico 8 - Lippia API Low-code -
  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2
    * define idWorkSpace = 670736518ba9f0235071f7e8


  @createProject @createProjectRequiredParameter @ej1 @TP8
  Scenario: Create a new project in workspace
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    * define valor aleatorio projectName
    And body jsons/bodies/addProject.json
    * print 'body'
    When execute method POST
    Then the status code should be 201
    * define projectId = $.id


  @getProjectById @ej2 @TP8
  Scenario: getProjectById
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects/671e5e9cb0b2ca255ed141a5
    When execute method GET
    Then the status code should be 200

  @editProject @ej3 @TP8
  Scenario: editProject
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects/671e5e9cb0b2ca255ed141a5
    And header Content-Type = application/json
    * define valor aleatorio editName
    And body jsons/bodies/editProject.json
    When execute method PUT
    Then the status code should be 200


  @happyPath @createProjectFullParams @ej4 @TP8
  Scenario: createProjectWithFullParameters
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    * define valor aleatorio name
    And body jsons/bodies/addProjectFullParams.json
    When execute method POST
    Then the status code should be 201
    And response should be $.hourlyRate.amount = 15000
    And response should be $.billable = true
    And response should be $.public = true



  @createProjectWithSomeOptionalParameters @ej4 @TP8
  Scenario: createProjectWithSomeOptionalParameters
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    * define valor aleatorio name
    And body jsons/bodies/addOptionalName.json
    When execute method POST
    Then the status code should be 201
    And print response
    And response should be $.public = true



 @createProjectWithoutName @parameterMandatory @ej4 @TP8
  Scenario: createProjectWithoutName
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectSinNombre.json
    When execute method POST
    Then the status code should be 400

  @createProjectInvalidParam @ej4 @TP8
  Scenario: createProjectWithInvalidParameter
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectParametroInvalido.json
    When execute method POST
    Then the status code should be 400


  @pruebaNoAutorizado @ej5 @TP8
  Scenario: createProjectWithoutAuthorization
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    * define valor aleatorio projectName
    And body jsons/bodies/addProject.json
    And header x-api-key = NGRhO
    When execute method POST
    Then the status code should be 401


  @pruebaNoEncontrada @getProjectWithInvalidId @ej6 @TP8
  Scenario: getProjectWithInvalidId
    Given endpoint /v1/workspaces/{{idWorkSpace}}/project/5b641568b07987035750505e
    When execute method GET
    Then the status code should be 404
    And response should be $.message = "No static resource v1/workspaces/{{idWorkSpace}}/project/5b641568b07987035750505e."
    And response should be $.code = 3000

  @createProjectInvalidParam @error400 @ej7 @TP8
  Scenario: createProjectWithInvalidParameter
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectParametroInvalido.json
    When execute method POST
    Then the status code should be 400
    And response should be $.message = "Project name has to be between 2 and 250 characters long"





















