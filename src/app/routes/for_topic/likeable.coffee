module.exports = (bookshelf, config) ->
  User  = (require "#{config.path.models}/user") bookshelf
  Topic = (require "#{config.path.models}/topic") bookshelf, User

  identify = (require "#{config.path.helpers}/identifier")

  index: ->
    unless @isAuthenticated()
      return @body = { likeable: false }

    like = yield bookshelf.knex('likes').where({
      user_id  : @passport.user.get 'id'
      topic_id : identify @params.id
    }).first().exec (error, like) ->

    @body = { likeable: true, like: !! like }

  store: ->
    @type = 'application/javascript'

    unless @isAuthenticated()
      return @body = 'location.pathname = "/login";'

    likeable = {
      user_id  : @passport.user.get 'id'
      topic_id : identify @params.id
    }

    like = yield bookshelf.knex('likes').where(likeable).first().exec (error, like) ->

    unless like
      yield bookshelf.knex('likes').insert(likeable).exec (error, like) ->

    @body = "$('.topic.show .likeable').addClass('actived').children('a').data('method', 'delete').attr('href', '/topic/#{@params.id}/unlike');"

  destroy: ->
    @type = 'application/javascript'

    unless @isAuthenticated()
      return @body = 'location.pathname = "/login";'

    likeable = {
      user_id  : @passport.user.get 'id'
      topic_id : identify @params.id
    }

    unlike = yield bookshelf.knex('likes').where(likeable).delete().exec (error, unlike) ->

    @body = "$('.topic.show .likeable').removeClass('actived').children('a').data('method', 'post').attr('href', '/topic/#{@params.id}/like');"
