Feature: GET Challenges

Background:
  * url baseURL
  * configure headers = headers

Scenario: GET /challenges
  Given path 'challenges'
  When method get
  Then status 200
  And match each response.challenges ==
    """
    {
      "name": '#string',
      "description": '#string',
      "id": '#string',
      "status": '#boolean'
    }
    """

Scenario: GET /todos 200
  Given path 'todos'
  When method get
  Then status 200
  And match each response.todos ==
    """
    {
    "doneStatus": '#boolean',
    "description": '#string',
    "id": '#number',
    "title": '#string'
    }
    """

Scenario: GET /todo 404
  Given path 'todo'
  When method get
  Then status 404

Scenario: GET /todos/{id} 200
  Given path 'todos'
  When method get
  Then status 200
  * def validId = response.todos[0].id
  Given path 'todos', validId
  When method get
  Then status 200

Scenario: GET /todos/{id} 404
  Given path 'todos'
  When method get
  Then status 200
  * def validIds = []
  * response.todos.forEach(todo => validIds.push(parseInt(todo.id)))
  * def invalidId = validIds.sort()[0] - 1
  Given path 'todos', invalidId
  When method get
  Then status 404
