module.exports = (bookshelf, config) ->
  User     = (require "#{config.path.models}/user") bookshelf
  Topic    = (require "#{config.path.models}/topic") bookshelf, User
  Category = (require "#{config.path.models}/category") bookshelf

  paginate = (require "#{config.path.helpers}/paginator")

  search: ->
    [queryString, currentPage, perPage] = [@query.q, @query.p or @query.page, 12]
    {perPage, currentPage, offsetValue, queryBuilder} = paginate currentPage, perPage

    topics = yield Topic
      .query((qb) -> qb.where 'title', 'LIKE', if queryString then "%#{queryString}%" else queryString)
      .query((qb) -> queryBuilder(qb).orderBy 'id', 'desc').fetchAll({ withRelated: ['user'] }).exec (error, topics) ->

    topicsCount = yield Topic.query().count('id as count').exec (error, count) ->

    yield @render 'topic/sortable/query', {
      topics      : topics.toJSON()
      topicsCount : topicsCount[0].count
      queryString : queryString
      currentPage : currentPage
      offsetValue : offsetValue
      perPage     : perPage
    }

  popular: ->
    [currentPage, perPage] = [@query.p or @query.page, 12]
    {perPage, currentPage, offsetValue, queryBuilder} = paginate currentPage, perPage

    topics = yield Topic.query((qb) -> queryBuilder(qb).orderBy 'ranking', 'desc').fetchAll({ withRelated: ['user'] }).exec (error, topics) ->

    topicsCount = yield Topic.query().count('id as count').exec (error, count) ->

    yield @render 'topic/sortable/popular'

  category: ->
    category = yield Category.where({ identifier: @params.identifier }).fetch().exec (error, category) ->

    unless category
      return yield @render '404'

    categories = yield Category.forge().fetchAll().exec (error, categories) ->

    topics = yield Topic.where({ category_id: category.get 'id' }).fetchAll({ withRelated: ['user'] }).exec (error, topics) ->

    yield @render 'topic/sortable/category', {
      category   : category.toJSON()
      categories : categories.toJSON()
    }

  likes: ->
    yield @render 'topic/sortable/likes'

  replies: ->
    yield @render 'topic/sortable/replies'
