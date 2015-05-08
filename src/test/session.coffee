module.exports = (server, request) ->
  describe 'GET /login', ->
    it 'responds with 200 OK', (done) ->
      request(server).get('/login').expect 200, done

  describe 'POST /session', ->
    it 'redirects to /login', (done) ->
      request(server).post('/session').expect(302).end (error, response) ->
        return done error if error
        response.header.location.should.equal '/login'
        done()

  describe 'DELETE /logout', ->
    it 'redirects to /login', (done) ->
      request(server).delete('/logout').expect(302).end (error, response) ->
        return done error if error
        response.header.location.should.equal '/login'
        done()

        # request(server).post('/session').send(user).expect(302).end (error, response) ->
        # it 'should redirect to /login via javascript', (done) ->
        #   request(server).post('/topic/1/like').set('X-Requested-With', 'xmlhttprequest').expect(200).end (error, response) ->
        #     return done error if error
        #     response.header['content-type'].should.match /javascript/
        #     response.text.should.match /login/
        #     done()
