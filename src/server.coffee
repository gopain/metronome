module.exports = (router, passport, config) ->
  knex      = (require 'knex') config.knex.development
  bookshelf = (require 'bookshelf') knex

  # router.param 'id', (id, next) ->
  #   unless id.match /^[\d]+$/
  #     return yield next

  #   @status = 404
  #   yield @render '404'

  router.param 'username', (username, next) ->
    if username.match /^[A-Z0-9a-z-_]+$/
      return yield next

    @status = 404
    yield @render '404'

  (require "#{config.path.routes}/passport") passport, bookshelf, config
  (require config.path.app) router, bookshelf, config

  router.post '/session', passport.authenticate 'local', {
    successRedirect: '/'
    failureRedirect: '/login'
  }
