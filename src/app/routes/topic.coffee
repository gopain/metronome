module.exports = (bookshelf, config) ->
  User     = (require "#{config.path.models}/user") bookshelf
  Text     = (require "#{config.path.models}/text") bookshelf
  Category = (require "#{config.path.models}/category") bookshelf
  Reply    = (require "#{config.path.models}/reply") bookshelf, User, Text
  Topic    = (require "#{config.path.models}/topic") bookshelf, User, Text, Category

  identify = (require "#{config.path.helpers}/identifier")
  paginate = (require "#{config.path.helpers}/paginator")
  sanitize = (require "#{config.path.helpers}/sanitizer")
  markdown = (require "#{config.path.helpers}/markdown")

  params = (require config.path.params) 'Topic', config

  # models =
  #   node  : require "#{config.path.models}/node"
  #   reply : require "#{config.path.models}/reply"
  # Node  = models.node bookshelf
  # Reply = models.reply bookshelf, User
  # knex  = bookshelf.knex

  new: ->
    unless @isAuthenticated()
      return @redirect '/login'

    categories = yield Category.forge().fetchAll().exec (error, categories) ->

    yield @render 'topic/new', { categories: categories.toJSON() }

  store: (next) ->
    unless @isAuthenticated()
      return @body = {}

    topic = params.validate @request.body

    if topic.permitted and source = topic.body
      topic = yield Topic.forge({
        title       : topic.title
        category_id : topic.categoryId
        user_id     : @passport.user.get 'id'
      }).save().exec (error, topic) ->

      yield Topic.forge({ id: topic.get 'id' })
        .save({ identifier: identify topic.get 'id' }, { patch: true })
        .exec (error, topic) ->

      yield Text.forge({
        html          : sanitize markdown source
        source        : source
        textable_id   : topic.get 'id'
        textable_type : 'topics'
      }).save().exec (error, text) ->

      yield bookshelf.knex 'categories'
        .where { id: topic.get 'category_id' }
        .increment 'topics_count', 1
        .exec (error, category) ->

      return @redirect '/'

    @redirect '/topic/new'

  show: ->
    topic = yield Topic.where({ id: identify @params.id })
      .fetch { withRelated: ['category', 'text', 'user'] }
      .exec (error, topic) ->

    replies = yield Reply.where({ id: topic.get 'id' })
      .fetchAll { withRelated: ['user'] }
      .exec (error, replies) ->

    yield @render 'topic/show', { topic: topic.toJSON() }

  edit: ->
    yield @render 'topic/edit'

  update: ->
    yield @render '404'

    # unless request.isAuthenticated()
    #   return response.status(404).render '404.jade'

    # Topic.where({ id: request.param('id') }).fetch({ withRelated: ['node', 'text'] }).then (topic) ->
    #   unless topic.get('user_id') is request.user.id
    #     return response.status(404).render '404.jade'

    #   Node.where({ super_id: 0 }).fetchAll({ withRelated: ['subnodes'] }).then (nodes) ->
    #     response.render 'topic/edit.jade',
    #       topic: topic.toJSON()
    #       nodes: nodes.toJSON()


  # update: (request, response, next) ->
  #   unless request.isAuthenticated()
  #     return response.json({})

  #   topic = params.validate(request.body)

  #   if topic.permitted
      # markup = topic.body
      # topic =
      #   title   : topic.title
      #   user_id : request.user.id
      #   node_id : node.id

      # Topic.where({ id: request.param('id') }).fetch().then (topic) ->
      #   unless topic.get('user_id') is request.user.id
      #     return response.json({})

      #   new Topic({ id: topic.get('id') }).save(topic, { patch: true }).then (topic) ->
      #     response.redirect "/topic/#{topic.id}"
