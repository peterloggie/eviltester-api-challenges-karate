Feature: DELETE Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  * configure headers = setup.headers

Scenario: DELETE /todos/{id} 200
  # Create a todo
  Given path 'todos'
  And request
  """
  {
    "doneStatus": true,
    "description": "This todo is going to get deleted",
    "title": "Eviltester with Karate - DELETE"
  }
  """
  When method post
  Then status 201
  * def todoId = response.id

  # Check we can retrieve the todo
  Given path 'todos', todoId
  When method get
  Then status 200

  # Delete the todo
  Given path 'todos', todoId
  When method delete
  Then status 200

  # Check we can't retrieve the todo
  Given path 'todos', todoId
  When method delete
  Then status 404

