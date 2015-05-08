module.exports = (server, request) ->
  describe 'GET /popular', ->
    it 'responds with 200 OK', (done) ->
      request(server).get('/popular').expect 200, done
