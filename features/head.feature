Feature: HEAD Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  * configure headers = setup.headers

Scenario: HEAD  /todos 200
  Given path 'todos'
  When method head
  Then status 200
