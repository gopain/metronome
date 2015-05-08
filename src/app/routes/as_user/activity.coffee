module.exports = (bookshelf, config) ->
  User = (require "#{config.path.models}/user") bookshelf

  index: ->
    user = yield User.where({ username: @params.username }).fetch().exec (error, user) ->

    unless user
      return yield @render '404'

    yield @render 'user/activity/index', { user: user.toJSON() }

    # User.where({ username: request.param('username') }).fetch().then (user) ->
    #   unless user
    #     return response.render '404.jade'
    #   response.render 'user/activity/index.jade',
    #     user: user.toJSON()
