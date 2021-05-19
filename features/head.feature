Feature: HEAD Challenges

Background:
  * url baseURL
  * configure headers = config.headers

Scenario: HEAD  /todos 200
  Given path 'todos'
  When method head
  Then status 200
