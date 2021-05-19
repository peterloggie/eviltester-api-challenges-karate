function fn() {
    var headers = karate.callSingle('./shared/set-headers.feature');
    var config = {
        headers,
        baseURL: 'http://apichallenges.herokuapp.com',
        challengerToken: headers.token
    }
    return config;
  }