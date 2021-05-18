Feature: Status Code Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  * configure headers = setup.headers
  Given path 'heartbeat'

Scenario: DELETE /heartbeat (405)
  When method delete
  Then status 405

Scenario: PATCH /heartbeat (500)
  When method patch
  Then status 500

Scenario: TRACE /heartbeat (501)
  When method trace
  Then status 501

Scenario: GET /heartbeat (204)
  When method get
  Then status 204