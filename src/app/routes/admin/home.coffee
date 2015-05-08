module.exports = (bookshelf, config) ->
  index: ->
    yield @render 'admin/home/index'
