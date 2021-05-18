Feature: Authentication Challenges

Background:
  * url 'http://apichallenges.herokuapp.com'
  * def setup = callonce read('./shared/set-headers.feature')
  * header X-Challenger = setup.token
  Given path 'secret/token'

Scenario: POST /secret/token (401)
  * header Authorization = call read('../helpers/basic_auth.js') { username: "invalid", password: "credentials" }
  When method post
  Then status 401

Scenario: POST /secret/token (201)
  * header Authorization = call read('../helpers/basic_auth.js') { username: "admin", password: "password" }
  When method post
  Then status 201
