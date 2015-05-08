module.exports = (server, request) ->
  describe 'GET /signup', ->
    it 'responds with 200 OK', (done) ->
      request(server).get('/signup').expect 200, done
