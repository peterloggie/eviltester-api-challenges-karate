@ignore
Feature: reusable feature to set the headers for all the challenges

Scenario:
  * url 'http://apichallenges.herokuapp.com'
  Given path 'challenger'
  When method post
  Then status 201
  * def token = responseHeaders['X-Challenger'][0]
  * match token == '#string'
  * def headers = { X-Challenger: '#(token)' }
