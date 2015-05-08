module.exports = (bookshelf, config) ->
  User = (require "#{config.path.models}/user") bookshelf

  store: ->
    user = yield User.where({ username: @params.username }).fetch().exec (error, user) ->

    unless user
      return yield @render '404'

    yield @render 'user/activity/index', { user: user.toJSON() }

  # store: (request, response, next) ->
  #   response.set 'Content-Type', 'application/javascript'
  #   if avatar.permitted
  #     unless fs.existsSync(avatar.path)
  #       return response.send ''

  #     gm(avatar.path).size (error, size) ->
  #       return { error: true } if error
  #       min = Math.min size.width, size.height, 320
  #       imagesPath = "config.images/#{avatar.name}"
  #       @gravity('Center').resize(min, min, '^>').crop(min, min).write imagesPath, (error) ->
  #         if fs.existsSync imagesPath
  #           gm(imagesPath).resize(56).write "config.avatars/#{avatar.name}", (error) ->
  #             fs.unlinkSync avatar.path
  #             new User({ id: request.user.id }).save({ avatar_url: "/avatars/#{avatar.name}" }, { patch: true }).then (user) ->
  #               response.send 'location.pathname = "/setting/avatar";'
  #   else
  #     fs.unlinkSync avatar.path if avatar.path
  #     response.send('')
