Feature: Clockify
#Ejemplo practico de clase
  Background:
    And base url https://api.clockify.me/api
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2

   @getAllWorkspace
  Scenario: getAllWorkspace
    Given base url https://api.clockify.me/api
    And endpoint /v1/workspaces
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].name = Angelica carrera
    * define idworkspace = $.[0].id


   @GetWorkspaceInfo
  Scenario: getAllWorkspaceinfo
    Given call Clockify.feature@getAllWorkspace
    And base url https://api.clockify.me/api
    And endpoint v1/workspaces/{{idworkspace}}
    And header x-api-key = NGRhOTUyYjQtN2UzMi00NDZmLWI4NDQtNGFkNDUxZTlmZTY2
    When execute method GET
    Then the status code should be 200

   @addWorkspace
   Scenario: addWorkspace
     Given endpoint /v1/workspaces
     And header Content-Type = application/json
     And body jsons/bodies/addWorkspace.json
     When execute method POST
     And the status code should be 201
     * define idworkspace = $.id

   @Clockify @addClient
   Scenario: addClient
     Given call Clockify.feature@GetWorkspaceInfo
     And endpoint /workspaces/{{idworkspace}}/clients
     And header Content-Type = application/json
     And body jsons/bodies/addClient.json
     When execute method POST
     And the status code should be 201

   @FindClientsOnWorkspace
   Scenario: Find clients on workspace
     Given call Clockify.feature@getAllWorkspace
     And endpoint /v1/workspaces/{{idworkspace}}/clients
     When execute method GET
     Then the status code should be 200
     * define idclient = $.[0].id

   @Clockify @deleteClient
   Scenario: Delete client from workspace
     Given call Clockify.feature@FindClientsOnWorkspace
     And endpoint /v1/workspaces/{{idworkspace}}/clients/{{idclient}}
     When execute method DELETE
     Then the status code should be 200








