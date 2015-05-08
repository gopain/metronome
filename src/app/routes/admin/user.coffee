module.exports = (bookshelf, config) ->
  User   = (require "#{config.path.models}/user") bookshelf

  index: ->
    users = yield User.fetchAll().exec (error, users) ->

    yield @render 'admin/user/index', { users: users.toJSON() }
