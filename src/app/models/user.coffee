module.exports = (bookshelf) ->
  User = bookshelf.Model.extend
    tableName: 'users'
    hasTimestamps: ['created_at', 'updated_at']

    topics        : -> @hasMany Topic
    events        : -> @hasMany Event
    replies       : -> @hasMany Reply
    notifications : -> @hasMany Notification
    likeable      : -> @morphTo 'likeable'
    followers     : -> @belongsToMany User, 'relations', 'followed_id', 'follower_id'
    following     : -> @belongsToMany User, 'relations', 'follower_id', 'followed_id'
