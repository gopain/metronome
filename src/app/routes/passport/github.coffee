module.exports = (bookshelf, config) ->
  qs      = require 'querystring'
  request = require 'request'

  User = (require "#{config.path.models}/user") bookshelf

  [clientId, clientSecret] = [process.env.GITHUB_CLIENT_ID, process.env.GITHUB_CLIENT_SECRET]

  new: ->
    yield `function*(){}`

    @redirect "https://github.com/login/oauth/authorize?client_id=#{clientId}"

  store: ->
    yield `function*(){}`

    request.post 'https://github.com/login/oauth/access_token?' + qs.stringify({
      code          : @query.code
      client_id     : clientId
      client_secret : clientSecret
    }), (error, response, body) =>
      return @body = {} if error

      request.get {
        json    : true
        headers : 'User-Agent' : 'metronome'
        url     : "https://api.github.com/user?access_token=#{qs.parse(body).access_token}"
      }, (error, response, body) =>
        return @body = {} if error

        console.log body
