module.exports = (bookshelf, config) ->
  index: ->
    yield @render 'message/index'

  destroy: ->
    yield @render '404'

    # unless request.isAuthenticated()
    #   return response.redirect '/login'
    # Notification.where({ user_id: request.user.id }).fetchAll().then (notifications) ->
    #   response.render 'notify/index.jade', { notifications: notifications.toJSON() }
