module.exports = (bookshelf, config) ->
  User = (require "#{config.path.models}/user") bookshelf

  new: ->
    yield @render 'user/password/new'

  store: ->
    yield @render 'user/profile/edit'

  edit: ->
    yield @render 'user/profile/edit'

  store: ->
    yield @render 'user/profile/edit'

  update: ->
    yield @render 'user/profile/edit'

  #   response.render 'user/password/edit.jade'
  # update: (request, response, next) ->
  #   # get current user
  #   # check current pw
  #   # check new pw | validate
  #   # save password
  #   response.redirect '/setting/password'
