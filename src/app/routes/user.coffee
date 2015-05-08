module.exports = (bookshelf, config) ->
  bcrypt = require 'bcrypt-nodejs'
  crypto = require 'crypto'

  User   = (require "#{config.path.models}/user") bookshelf
  params = (require config.path.params) 'User', config

  superred = process.env.SUPERRED or 'ghost'

  new: ->
    yield @render 'user/new', @flash or {}

  store: ->
    user = params.validate @request.body

    if user.permitted
      _user = yield User.query({
        where   : username : user.username
        orWhere : email    : user.email
      }).fetch().exec (error, _user) ->

      unless _user
        md5 = crypto.createHash 'md5'
          .update user.email
          .digest 'hex'

        user = yield new User({
          email      : user.email
          username   : user.username
          downcase   : user.username.toLowerCase()
          password   : bcrypt.hashSync user.password
          superred   : user.username is superred
          avatar_url : "https://secure.gravatar.com/avatar/#{md5}?d=mm&r=pg&s=56"
        }).save().exec (error, user) ->

        yield @login user if user
        return @redirect '/'

      if user.username is _user.get 'username'
        user.messages.push 'messages.username_is_already_taken'

      if user.email is _user.get 'email'
        user.messages.push 'messages.email_is_already_taken'

    @flash = {
      alert : user.messages[0]
      user  : username : user.username, email : user.email
    }

    @redirect '/signup'

  # show: (request, response, next) ->
  #   # find user downcase/username
  #   User.where({ username: request.param('username') }).fetch({ withRelated: ['profile', 'stat'] }).then (user) ->
  #     unless user
  #       return response.status(404).render '404.jade'
  #     response.render 'user/show.jade',
  #       user: user.toJSON()

  show: ->

    # User.where({ username: request.param('username') }).fetch().then (user) ->
    #   unless user
    #     return response.render '404.jade'

    #   Topic.where({ user_id: user.get('id') }).fetchAll().then (topics) ->
    #     response.render 'user/topic/index.jade',
    #       topics: topics.toJSON()
    #       user: user.toJSON()

    user = yield User.where({ username: @params.username }).fetch().exec (error, user) ->

    unless user
      return yield @render '404'

    yield @render 'user/show', { user: user.toJSON() }
