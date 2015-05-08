module.exports = (server, i18n, config) ->
  i18n.configure config.i18n

  server.use (next) ->
    if @method is 'GET'
      @state =
        csrf : @csrf
        i18n : i18n.__
        isAuthenticated : @isAuthenticated()
      if @isAuthenticated()
        @state.currentUser = @passport.user.toJSON()

    yield next

  server.use (next) ->
    if @request.url.match /^\/admin\/?/
      unless @isAuthenticated()
        return @redirect '/login'

      unless @passport.user.get('superred')
        @status = 404
        return yield @render '404'

    yield next

  server.use (next) ->
    if @request.url.match /^\/setting\/?/
      unless @isAuthenticated()
        return @redirect '/login'

    yield next
