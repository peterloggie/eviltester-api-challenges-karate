Feature: 'Accept' Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  # curiously, XML Schemas are described using JSON objects in Karate
  * def XMLSchema =
  """
  {
    "doneStatus": '#string',
    "description": '##string',
    "id": '#string',
    "title": '#string'
  }
  """
  # The JSON Schema has more types available for validation
  * def JSONSchema =
  """
  {
    "doneStatus": '#boolean',
    "description": '##string',
    "id": '#number',
    "title": '#string'
  }
  """

Scenario: GET /todos (200) XML
  * configure headers = { 'Accept': 'application/xml', 'X-Challenger': '#(setup.token)' }
  Given path 'todos'
  When method get
  * xml todosList = get response // todos
  Then status 200
  And match each todosList.todos.todo == XMLSchema

Scenario: GET /todos (200) JSON
  * configure headers = { 'Accept': 'application/json', 'X-Challenger': '#(setup.token)' }
  Given path 'todos'
  When method get
  Then status 200
  Then match each response.todos == JSONSchema

Scenario: GET /todos (200) ANY
  * configure headers = { 'Accept': '*/*', 'X-Challenger': '#(setup.token)' }
  Given path 'todos'
  When method get
  Then status 200
  Then match each response.todos == JSONSchema

Scenario: GET /todos (200) XML pref
  * configure headers = { 'Accept': 'application/xml, application/json', 'X-Challenger': '#(setup.token)' }
  Given path 'todos'
  When method get
  Then status 200
  * xml todosList = get response // todos
  And match each todosList.todos.todo == XMLSchema

Scenario: GET /todos (200) no accept
  * configure headers = { 'X-Challenger': '#(setup.token)' }
  Given path 'todos'
  When method get
  Then status 200
  And match each response.todos == JSONSchema

Scenario: GET /todos (406)
  * configure headers = { 'Accept': 'application/gzip', 'X-Challenger': '#(setup.token)' }
  Given path 'todos'
  When method get
  Then status 406
  And match response.errorMessages contains "Unrecognised Accept Type"
