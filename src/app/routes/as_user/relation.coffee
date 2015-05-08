module.exports = (bookshelf, config) ->
  User     = (require "#{config.path.models}/user") bookshelf
  Relation = (require "#{config.path.models}/relation") bookshelf, User

  followers: ->
    user = yield User.where({ username: @params.username }).fetch({ withRelated: ['followers'] }).exec (error, user) ->

    unless user
      return yield @render '404'

    yield @render 'user/relation/followers', { user: user.toJSON() }

  following: ->
    user = yield User.where({ username: @params.username }).fetch({ withRelated: ['following'] }).exec (error, user) ->

    unless user
      return yield @render '404'

    yield @render 'user/relation/following', { user: user.toJSON() }

  # store: (request, response, next) ->
  #   unless request.xhr
  #     return response.render '404.jade'
  #   response.set 'Content-Type', 'application/javascript'

  #   unless request.isAuthenticated()
  #     return response.send 'location.pathname = "/login"'

  #   User.where({ username: request.query.target }).fetch().then (followed) ->
  #     unless followed
  #       return response.send ''

  #     return response.send '' if followed.get('id') is request.user.get('id')

  #     relation =
  #       followed_id: followed.get('id')
  #       follower_id: request.user.get('id')

  #     new Relation(relation).fetch().then (following) ->
  #       return response.send '' if following
  #       new Relation(relation).save().then ->
  #         response.send '$("a[data-relation=' + followed.get('username') + ']").data("method", "delete").attr("href", "/unfollow?target=' + followed.get('username') + '");'

  # show: (request, response, next) ->

  # destroy: (request, response, next) ->
  #   unless request.xhr
  #     return response.render '404.jade'
  #   response.set 'Content-Type', 'application/javascript'

  #   unless request.isAuthenticated()
  #     return response.send 'location.pathname = "/login"'

  #   User.where({ username: request.query.target }).fetch().then (followed) ->
  #     unless followed
  #       return response.send ''

  #     Relation.where({ followed_id: followed.get('id'), follower_id: request.user.get('id') }).destroy().then ->
  #       response.send '$("a[data-relation=' + followed.get('username') + ']").data("method", "post").attr("href", "/follow?target=' + followed.get('username') + '");'
