Feature: Post Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  * configure headers = setup.headers

Scenario: POST /todos 201
  Given path 'todos'
  And request
  """
  {
    "doneStatus": false,
    "description": "Do the Eviltester POST challenges using Karate",
    "title": "Eviltester with Karate - POST"
  }
  """
  When method post
  Then status 201

Scenario: GET /todos 200 ? filter
  Given path 'todos'
  And request
  """
  {
    "doneStatus": true,
    "description": "Do the Eviltester GET challenges using Karate",
    "title": "Eviltester with Karate - GET"
  }
  """
  When method post
  Then status 201
  * def newTodoId = response.id
  Given path 'todos'
  Given param doneStatus = true
  When method get
  Then status 200
  And match response.todos contains
  """
  {
    "id": '#(newTodoId)',
    "doneStatus": true,
    "description": "Do the Eviltester GET challenges using Karate",
    "title": "Eviltester with Karate - GET"
  }
  """

Scenario: POST /todos 400 fail validation on 'doneStatus' field
  Given path 'todos'
  And request
  """
  {
    "doneStatus": 1,
    "description": "Should fail because doneStatus is invalid",
    "title": "Failed POST"
  }
  """
  When method post
  Then status 400
  And match response.errorMessages contains "Failed Validation: doneStatus should be BOOLEAN"

Scenario: POST /todos 200 update an existing todo
  # Create the todo
  Given path 'todos'
  And request
  """
  {
    "doneStatus": false,
    "description": "This task has not been done yet.",
    "title": "Task to update"
  }
  """
  When method post
  Then status 201
  * def newTodoId = response.id

  # Update the todo
  Given path 'todos', newTodoId
  And request
  """
  {
    "doneStatus": true,
    "description": "Now we've done it"
  }
  """
  When method post
  Then status 200
  And match response ==
  """
  {
    "id": '#(newTodoId)',
    "doneStatus": true,
    "description": "Now we've done it",
    "title": "Task to update"
  }
  """

