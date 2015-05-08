module.exports = (server, request) ->
  describe 'GET /', ->
    it 'responds with 200 OK', (done) ->
      request(server).get('/').expect 200, done
