Feature: OPTIONS Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  * configure headers = setup.headers

Scenario: OPTIONS /todos 200
  Given path 'todos'
  When method options
  Then match responseHeaders['Allow'] == ['OPTIONS, GET, HEAD, POST']