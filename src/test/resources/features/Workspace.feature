Feature: Workspace
#ejercitacion en clase
  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2


  @crearProyecto
  Scenario: Create a new project in workspace
    Given call Clockify.feature@GetWorkspaceInfo
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    And header Content-Type = application/json
    And body jsons/bodies/addProjectW.json
    When execute method POST
    Then the status code should be 201
    * define idProject = $.id


   @getProjectById
  Scenario: Get Project by ID
    Given call Clockify.feature@getAllWorkspace
    And endpoint /v1/workspaces/{{idworkspace}}/projects
    When execute method GET
    Then the status code should be 200

  @editProjectWorkspace
  Scenario: editProject
    Given call Workspace.feature@crearProyecto
    And endpoint /v1/workspaces/{{idworkspace}}/projects/{{idProject}}
    And header Content-Type = application/json
    And body jsons/bodies/editarProyecto.json
    When execute method PUT
    Then the status code should be 200






