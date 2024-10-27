Feature: Proyecto Final - ABM de horarios

  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2
    * define idWorkSpace = 670736518ba9f0235071f7e8
    * define userID = 66fc4bdfabb3a15f171f15c9
    * define projectId = 671e65c2f251712419c525df

  @tpf @tpf1
  Scenario: Consulta de horas registradas
    Given endpoint /v1/workspaces/{{idWorkSpace}}/user/{{userID}}/time-entries
    And header Content-Type = application/json
    When execute method GET
    Then the status code should be 200
    And print response



  @tpf @tpf2
  Scenario: Agregar horas a un proyecto
    Given endpoint /v1/workspaces/{{idWorkSpace}}/time-entries
    And body jsons/bodies/addTimeProject.json
    And header Content-Type = application/json
    When execute method POST
    Then the status code should be 201
    And print response
    * define idTime = $.id


  @tpf @tpf3
  Scenario: Editar un campo de algún registro de hora
    Given call tpfinal.feature@tpf2
    And endpoint /v1/workspaces/{{idWorkSpace}}/time-entries/{{idTime}}
    * define description = Campo Editado
    And body jsons/bodies/editTimeProject.json
    And header Content-Type = application/json
    When execute method PUT
    Then the status code should be 200
    And print response

  @tpf @tpf4
  Scenario: Eliminar hora registrada
    Given call tpfinal.feature@tpf2
    And endpoint /v1/workspaces/{{idWorkSpace}}/time-entries/{{idTime}}
    And header Content-Type = application/json
    When execute method DELETE
    Then the status code should be 204



