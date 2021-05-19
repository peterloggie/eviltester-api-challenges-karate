Feature: Authentication Challenges

Background:
  * url baseURL
  * header X-Challenger = config.challengerToken
  Given path 'secret/token'

Scenario: POST /secret/token (401)
  * header Authorization = call read('../helpers/basic_auth.js') { username: "invalid", password: "credentials" }
  When method post
  Then status 401

Scenario: POST /secret/token (201)
  * header Authorization = call read('../helpers/basic_auth.js') { username: "admin", password: "password" }
  When method post
  Then status 201
