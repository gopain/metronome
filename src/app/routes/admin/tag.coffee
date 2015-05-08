module.exports = (bookshelf, config) ->
  index: ->
    yield @render 'admin/tag/index'
