Feature: 'Accept' Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  Given path 'todos'

Scenario: POST /todos XML
  * configure headers = { 'Content-Type': 'application/xml', 'Accept': 'application/xml', 'X-Challenger': '#(setup.token)' }
  Given request
  """
  <todo>
    <doneStatus>false</doneStatus>
    <description>"POST: content-type xml, accept xml"</description>
    <title>"XML Content-Type"</title>
  </todo>
  """
  When method post
  Then status 201

Scenario: POST /todos JSON
  * configure headers = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-Challenger': '#(setup.token)' }
  Given request
  """
  {
    "doneStatus": false,
    "description": "POST: content-type json, accept json",
    "title": "JSON Content-Type"
  }
  """
  When method post
  Then status 201

Scenario: POST /todos (415)
  * configure headers = { 'Content-Type': 'application/gzip', 'Accept': '*/*', 'X-Challenger': '#(setup.token)' }
  Given request
  """
  {
    "doneStatus": false,
    "description": "POST: content-type gzip, accept default",
    "title": "JSON Content-Type"
  }
  """
  When method post
  Then status 415
  And match response.errorMessages contains "Unsupported Content Type - application\/gzip; charset=utf-8"