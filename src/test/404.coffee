module.exports = (server, request) ->
  describe 'GET /404', ->
    it 'responds with 404 NOT FOUND', (done) ->
      request(server).get('/404').expect(404).end (error, response) ->
        return done error if error
        response.should.be.html
        done()
