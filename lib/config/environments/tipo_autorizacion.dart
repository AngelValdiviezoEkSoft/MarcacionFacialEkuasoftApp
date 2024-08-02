class AuthType {
  Map<String, String> authBasic = {'Authorization': 'Basic'};
  Map<String, String> authBearer = {'Authorization': 'Bearer'};
  Map<String, String> authBearerCompletar = {'Authorization': 'Bearer'};
/*
  AuthType(String varTokenAut) {
    authBasic = {'Authorization': 'Basic $varTokenAut'};
    authBearer = {
      'Authorization': 'Bearer $varTokenAut',
      "apiKey":
          "eyJ4NXQiOiJOMkpqTWpOaU0yRXhZalJrTnpaalptWTFZVEF4Tm1GbE5qZzRPV1UxWVdRMll6YzFObVk1TlE9PSIsImtpZCI6ImdhdGV3YXlfY2VydGlmaWNhdGVfYWxpYXMiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcGlzdWJzY3JpYmVyQGNhcmJvbi5zdXBlciIsImFwcGxpY2F0aW9uIjp7Im93bmVyIjoiYXBpc3Vic2NyaWJlciIsInRpZXJRdW90YVR5cGUiOm51bGwsInRpZXIiOiJVbmxpbWl0ZWQiLCJuYW1lIjoiQ0ZBVk9SSVRBLUZJTi1ST09UIiwiaWQiOjkyLCJ1dWlkIjoiY2I0M2ZjNWQtMTgyNC00NDVjLThhMjUtZmJiOGIwMjIyMWUzIn0sImlzcyI6Imh0dHBzOlwvXC9zdnItajEwMGY3ZmI6MzA0NDNcL29hdXRoMlwvdG9rZW4iLCJ0aWVySW5mbyI6eyJVbmxpbWl0ZWQiOnsidGllclF1b3RhVHlwZSI6InJlcXVlc3RDb3VudCIsImdyYXBoUUxNYXhDb21wbGV4aXR5IjowLCJncmFwaFFMTWF4RGVwdGgiOjAsInN0b3BPblF1b3RhUmVhY2giOnRydWUsInNwaWtlQXJyZXN0TGltaXQiOjAsInNwaWtlQXJyZXN0VW5pdCI6bnVsbH19LCJrZXl0eXBlIjoiUFJPRFVDVElPTiIsInBlcm1pdHRlZFJlZmVyZXIiOiJ3d3cucGFnb3BsdXguY2Zhdm9yaXRhLmFwaU1vdmlsLmNvbVwvKiIsInN1YnNjcmliZWRBUElzIjpbeyJzdWJzY3JpYmVyVGVuYW50RG9tYWluIjoiY2FyYm9uLnN1cGVyIiwibmFtZSI6IkZJTi1ST09UIiwiY29udGV4dCI6IlwvYXBpRmlubGFuZGlhXC92MSIsInB1Ymxpc2hlciI6ImFwaWRldmVsb3BlciIsInZlcnNpb24iOiJ2MSIsInN1YnNjcmlwdGlvblRpZXIiOiJVbmxpbWl0ZWQifV0sInRva2VuX3R5cGUiOiJhcGlLZXkiLCJwZXJtaXR0ZWRJUCI6IiIsImlhdCI6MTY5NDYzNjA3MCwianRpIjoiMzc4N2NiMDQtOGJiOC00NTQyLTk5NjUtMGQyZGY2MzdjNmQ3In0=.LF4-SRTkV2CgdxhSI_vqW03Guw1YV1z6eXighMfahSellTtLzcelA57H6X_PMDoaOB3pvk0CQ8EPhfC5_EiSnAfAwBUtLF6f3KazfNFNcDaMKNW6Xqr2terAoCaEKDcDwjw1Qaf5QurfkxUNbobd6EUWImMg1jtap0J6kto3gdPBt8F31VtY_PByKsRk9GgMc5me8rL7fAhvyzIwHLUCPJ29T-Ri55feX8CXbCvXf643DdUPgu1IcBaPNNhseKAeofKsmZPXgR0LM2QLe2Z6xSOeb80QfSpgGfsa2cuLLwD-rAwG3XAqaoD8FS4dqi9T81TAWAyDaENmywvLw0awjw",
      "Referer": "www.pagoplux.cfavorita.apiMovil.com/",
    };
    authBearerCompletar = {'Authorization': 'Bearer $varTokenAut'};
  }
*/
  AuthType(){
    authBasic = {
      'Cookie': 'session_id=8d9fa51c96e0933ca9f086cba1c49dc073450deb',
    };
  }
}

class ContType {
  Map<String, String> contentType = {};
  ContType() {
    contentType = {'Content-Type': 'application/json'};
  }
}

class SymetricKey {
  Map<String, String> symetricKey = {};
  SymetricKey(String key) {
    symetricKey = {'simetricKey': key};
  }
}

class ApiKey {
  Map<String, String> apiKey = {};
  ApiKey() {
    apiKey = {
      'apiKey':
          "eyJ4NXQiOiJOMkpqTWpOaU0yRXhZalJrTnpaalptWTFZVEF4Tm1GbE5qZzRPV1UxWVdRMll6YzFObVk1TlE9PSIsImtpZCI6ImdhdGV3YXlfY2VydGlmaWNhdGVfYWxpYXMiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJhcGlzdWJzY3JpYmVyQGNhcmJvbi5zdXBlciIsImFwcGxpY2F0aW9uIjp7Im93bmVyIjoiYXBpc3Vic2NyaWJlciIsInRpZXJRdW90YVR5cGUiOm51bGwsInRpZXIiOiJVbmxpbWl0ZWQiLCJuYW1lIjoiQ0ZBVk9SSVRBLUZJTi1ST09UIiwiaWQiOjkyLCJ1dWlkIjoiY2I0M2ZjNWQtMTgyNC00NDVjLThhMjUtZmJiOGIwMjIyMWUzIn0sImlzcyI6Imh0dHBzOlwvXC9zdnItajEwMGY3ZmI6MzA0NDNcL29hdXRoMlwvdG9rZW4iLCJ0aWVySW5mbyI6eyJVbmxpbWl0ZWQiOnsidGllclF1b3RhVHlwZSI6InJlcXVlc3RDb3VudCIsImdyYXBoUUxNYXhDb21wbGV4aXR5IjowLCJncmFwaFFMTWF4RGVwdGgiOjAsInN0b3BPblF1b3RhUmVhY2giOnRydWUsInNwaWtlQXJyZXN0TGltaXQiOjAsInNwaWtlQXJyZXN0VW5pdCI6bnVsbH19LCJrZXl0eXBlIjoiUFJPRFVDVElPTiIsInBlcm1pdHRlZFJlZmVyZXIiOiJ3d3cucGFnb3BsdXguY2Zhdm9yaXRhLmFwaU1vdmlsLmNvbVwvKiIsInN1YnNjcmliZWRBUElzIjpbeyJzdWJzY3JpYmVyVGVuYW50RG9tYWluIjoiY2FyYm9uLnN1cGVyIiwibmFtZSI6IkZJTi1ST09UIiwiY29udGV4dCI6IlwvYXBpRmlubGFuZGlhXC92MSIsInB1Ymxpc2hlciI6ImFwaWRldmVsb3BlciIsInZlcnNpb24iOiJ2MSIsInN1YnNjcmlwdGlvblRpZXIiOiJVbmxpbWl0ZWQifV0sInRva2VuX3R5cGUiOiJhcGlLZXkiLCJwZXJtaXR0ZWRJUCI6IiIsImlhdCI6MTY5NDYzNjA3MCwianRpIjoiMzc4N2NiMDQtOGJiOC00NTQyLTk5NjUtMGQyZGY2MzdjNmQ3In0=.LF4-SRTkV2CgdxhSI_vqW03Guw1YV1z6eXighMfahSellTtLzcelA57H6X_PMDoaOB3pvk0CQ8EPhfC5_EiSnAfAwBUtLF6f3KazfNFNcDaMKNW6Xqr2terAoCaEKDcDwjw1Qaf5QurfkxUNbobd6EUWImMg1jtap0J6kto3gdPBt8F31VtY_PByKsRk9GgMc5me8rL7fAhvyzIwHLUCPJ29T-Ri55feX8CXbCvXf643DdUPgu1IcBaPNNhseKAeofKsmZPXgR0LM2QLe2Z6xSOeb80QfSpgGfsa2cuLLwD-rAwG3XAqaoD8FS4dqi9T81TAWAyDaENmywvLw0awjw",
    };
  }
}
