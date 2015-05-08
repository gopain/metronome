module.exports = (bookshelf, User, Topic) ->
  bookshelf.Model.extend
    tableName: 'replies'
    hasTimestamps: ['created_at', 'updated_at']

    user  : -> @belongsTo User if User
    topic : -> @belongsTo Topic if Topic
