module.exports = (bookshelf, config) ->
  new: ->
    yield @render 'session/new', @flash or {}

  destroy: ->
    yield `function*(){}`

    @logout()
    @redirect '/'
