module.exports = (bookshelf, Topic) ->
  bookshelf.Model.extend
    tableName: 'categories'
    hasTimestamps: ['created_at', 'updated_at']

    topics: -> @hasMany Topic if Topic
