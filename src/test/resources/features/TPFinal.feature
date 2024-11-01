Feature: Proyecto Final - ABM de horarios

  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2
    #* define idWorkSpace = 670736518ba9f0235071f7e8
    #* define userId = 66fc4bdfabb3a15f171f15c9
    #* define projectId = 671e65c2f251712419c525df

  @retrieveTimeEntry @tpf @allWorkspaces
  Scenario: Consulta los workspaces
    Given endpoint /v1/workspaces/
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    #And print response
    * define idWorkSpace = $.[0].id

  @allProjectoWorkspaces
  Scenario: Consulta los projecto de workspaces
    Given call TPFinal.feature@allWorkspaces
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    #And print response
    * define projectId = $.[0].id

    #Consulto las horas registradas de un projecto
  @tpf1
  Scenario: Consulta un projecto de workspaces
    Given call TPFinal.feature@allProjectoWorkspaces
    Given endpoint /v1/workspaces/{{idWorkSpace}}/projects/{{projectId}}
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    And print response
    #* define projectId = $.[0].id




  #BORRAR
  @retrieveTimeEntry @tpf
  Scenario: Consulta de horas registradas
    Given endpoint /v1/workspaces/{{idWorkSpace}}/user/{{userId}}/time-entries
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    And print response


  @addTimeEntry @tpf @tpf2  @AngiTest
  Scenario Outline: Agregar horas a un proyecto
    Given call TPFinal.feature@allProjectoWorkspaces
    Given endpoint /v1/workspaces/{{idWorkSpace}}/time-entries

    * define description = "<description>"
    * define start = "<start>"
    * define end = "<end>"

    And body jsons/bodies/addTimeProject.json
    And header Content-Type = application/json
    When execute method POST
    Then the status code should be 201
    And print response
    * define idTime = $.id
    #And validate response should be Automatizacion LIPPIA LOW CODE = $.description
    Examples:
      | description   | start                | end                  |
      | Agregar horas | 2024-10-26T09:00:00Z | 2024-10-26T11:00:00Z |


  @editTimeEntry @tpf @tpf3
  Scenario: Editar un campo de algún registro de hora
    Given call TPFinal.feature@addTimeEntry
    And endpoint /v1/workspaces/{{idWorkSpace}}/time-entries/{{idTime}}
    * define description = Campo Editado
    And body jsons/bodies/editTimeProject.json
    And header Content-Type = application/json
    When execute method PUT
    Then the status code should be 200
    And print response

  @deleteTimeEntry @tpf @tpf4
  Scenario: Eliminar hora registrada
    Given call TPFinal.feature@addTimeEntry
    And endpoint /v1/workspaces/{{idWorkSpace}}/time-entries/{{idTime}}
    And header Content-Type = application/json
    When execute method DELETE
    Then the status code should be 204



