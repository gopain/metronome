module.exports = (bookshelf, config) ->
  Category = (require "#{config.path.models}/category") bookshelf

  params = (require config.path.params) 'Category', config

  index: ->
    categories = yield Category.forge().fetchAll().exec (error, categories) ->

    yield @render 'admin/category/index', { categories: categories.toJSON() }

  new: ->
    yield @render 'admin/topic/new'

  store: ->
    category = params.validate @request.body

    if category.permitted
      yield new Category({
        name       : category.name
        identifier : category.identifier
      }).save().exec (error, category) ->

    @redirect '/admin/categories'

  edit: ->
    category = yield Category.forge({ id: @params.id }).fetch().exec (error, category) ->

    unless category
      @status = 404
      return @render '404'

    yield @render 'admin/category/edit', { category: category.toJSON() }

  update: ->
    category = params.validate @request.body

    unless category.permitted
      return @redirect '/admin/categories'

    yield Category.forge { id: @params.id }
      .save({
        name       : category.name
        identifier : category.identifier
      }, { patch: true }).exec (error, category) ->

    @redirect '/admin/categories'
    # yield @render '/admin/category/edit', { category: category }

  destroy: ->
    yield Category.forge { id: @params.id }
      .destroy().exec (error, category) ->

    @redirect '/admin/categories'
