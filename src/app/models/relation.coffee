module.exports = (bookshelf, User) ->
  bookshelf.Model.extend
    tableName: 'relations'

    follower: -> @belongsTo User, 'follower_id' if User
    followed: -> @belongsTo User, 'followed_id' if User
