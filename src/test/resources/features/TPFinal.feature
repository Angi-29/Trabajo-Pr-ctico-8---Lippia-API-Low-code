
Feature: Final Project - ABM of schedules

  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2


  ## PRECONDICION PARA NO DEPENDER DE WORKSPACE CREADO , PROJECTOS y TIEMPOS AGREGADOS##
  @addWorkspace
  Scenario: addWorkspace
    Given endpoint /v1/workspaces
    And header Content-Type = application/json
    And body jsons/bodies/addWorkspace.json
    When execute method POST
    And the status code should be 201
    * define idWorkSpace = $.id

  @addProjectWorkSpace
  Scenario: Create a new project in workspace
    Given call TPFinal.feature@addWorkspace
    And endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    * define valor aleatorio projectName
    And body jsons/bodies/addProject.json
    * print 'body'
    When execute method POST
    Then the status code should be 201
    * define projectId = $.id

  @addTimeProjectWorkSpace
  Scenario: Add hours to a project
    Given call TPFinal.feature@addProjectWorkSpace
    Given endpoint /v1/workspaces/{{idWorkSpace}}/time-entries
    * define description = "Agregar horas a un proyecto"
    * define start = "2024-10-26T09:00:00Z"
    * define end = "2024-10-26T11:00:00Z"
    And body jsons/bodies/addTimeProject.json
    And header Content-Type = application/json
    When execute method POST
    Then the status code should be 201

  ##############################################################################

  @getProject @tpf1 @tpf
  Scenario: Get of a project in a workspace
    Given call TPFinal.feature@addTimeProjectWorkSpace
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{projectId}}
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    And print response
    * define duration = $.duration
    And response should be duration = "PT2H"

  @addTimeEntry @tpf @tpf2
  Scenario Outline: Add hours to a created project
    Given call TPFinal.feature@addTimeProjectWorkSpace
    Given endpoint /v1/workspaces/{{idWorkSpace}}/time-entries
    * define description = "<description>"
    * define start = "<start>"
    * define end = "<end>"
    And body jsons/bodies/addTimeProject.json
    And header Content-Type = application/json
    When execute method POST
    Then the status code should be 201
    And print response
    * define description = $.description
    And response should be description = "<description>"
    * define timeInterval.start = $.timeInterval.start
    * define timeInterval.end = $.timeInterval.end
    * define timeInterval.duration = $.timeInterval.duration
    And response should be timeInterval.start = "<start>"
    And response should be timeInterval.end = "<end>"
    And response should be timeInterval.duration = "<horas>"
    * define idTime = $.id
    Examples:
      | description   | start                | end                  | horas |
      | Agregar horas | 2024-10-26T09:00:00Z | 2024-10-26T11:00:00Z | PT2H  |


  @editTimeEntry @tpf @tpf3
  Scenario Outline: Edit a field of some time stamp
    Given call TPFinal.feature@addTimeEntry
    And endpoint /v1/workspaces/{{idWorkSpace}}/time-entries/{{idTime}}
    * define description = "<description>"
    And body jsons/bodies/editTimeProject.json
    And header Content-Type = application/json
    When execute method PUT
    Then the status code should be 200
    And print response
    * define description = $.description
    And response should be description = "<description>"
    Examples:
      | description                               |
      | Editar un campo de algun registro de hora |

  @deleteTimeEntry @tpf @tpf4
  Scenario:Delete registered time
    Given call TPFinal.feature@addTimeEntry
    And endpoint /v1/workspaces/{{idWorkSpace}}/time-entries/{{idTime}}
    And header Content-Type = application/json
    When execute method DELETE
    Then the status code should be 204
    And print response





