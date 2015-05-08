module.exports = (bookshelf, User) ->
  bookshelf.Model.extend
    tableName: 'messages'

    user: -> @belongsTo User if User
