module.exports = (bookshelf, config) ->
  User     = (require "#{config.path.models}/user") bookshelf
  Text     = (require "#{config.path.models}/text") bookshelf
  Category = (require "#{config.path.models}/category") bookshelf
  Topic    = (require "#{config.path.models}/topic") bookshelf, User, Text, Category

  paginate = (require "#{config.path.helpers}/paginator")

  index: ->
    [currentPage, perPage] = [@query.p or @query.page, 12]
    {perPage, currentPage, offsetValue, queryBuilder} = paginate currentPage, perPage

    topics = yield Topic.query((qb) -> queryBuilder(qb).orderBy 'id', 'desc').fetchAll({ withRelated: ['user'] }).exec (error, topics) ->

    topicsCount = yield Topic.query().count('id as count').exec (error, count) ->

    yield @render 'admin/topic/index', {
      topicsCount : topicsCount[0].count
      topics      : topics.toJSON()
      offsetValue : offsetValue
      currentPage : currentPage
      perPage     : perPage
    }

  destroy: ->
    yield Topic.forge { id: @params.id }
      .destroy().exec (error, topic) ->

    @redirect '/admin/topics'
