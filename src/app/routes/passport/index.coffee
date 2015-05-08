module.exports = (passport, bookshelf, config) ->
  bcrypt        = require 'bcrypt-nodejs'
  LocalStrategy = (require 'passport-local').Strategy
  User          = (require "#{config.path.models}/user") bookshelf

  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    User.forge({ id: id }).fetch().then (user) ->
      done null, user

  passport.use new LocalStrategy {
    passReqToCallback : true
    usernameField     : 'login'
    passwordField     : 'password'
  }, (request, login, password, done) ->
    [user, login] = [{}, login.trim()]

    if login.match /\@/
      user.email = login
    else
      user.username = login

    User.where(user).fetch().then (user) ->
      if user and bcrypt.compareSync password, user.get('password')
        done null, user
      else
        request.flash = { alert: 'messages.login_credentials_invalid' }
        done null, false
