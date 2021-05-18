Feature: 'Accept' Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  Given path 'todos'

Scenario: POST /todos XML to JSON
  * configure headers = { 'Content-Type': 'application/xml', 'Accept': 'application/json', 'X-Challenger': '#(setup.token)' }
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
  And responseHeaders['Content-Type'] == 'application/json'

Scenario: POST /todos JSON to XML
  * configure headers = { 'Content-Type': 'application/json', 'Accept': 'application/xml', 'X-Challenger': '#(setup.token)' }
  Given request
  """
  {
    "doneStatus": false,
    "description": "Here we send json and receive an xml response",
    "title": "json to xml"
  }
  """
  When method post
  Then status 201
  And responseHeaders['Content-Type'] == 'application/xml'