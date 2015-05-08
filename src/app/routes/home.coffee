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

    categories = yield Category.forge().fetchAll().exec (error, categories) ->

    yield @render 'home/index', {
      topicsCount : topicsCount[0].count
      categories  : categories.toJSON()
      topics      : topics.toJSON()
      offsetValue : offsetValue
      currentPage : currentPage
      perPage     : perPage
    }

    #   Node.where({ super_id: 0 }).fetchAll({ withRelated: ['subnodes'] }).then (nodes) ->
    #       nodes: nodes.toJSON()
