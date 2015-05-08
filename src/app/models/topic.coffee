module.exports = (bookshelf, User, Text, Category) ->
  bookshelf.Model.extend
    tableName: 'topics'
    hasTimestamps: ['created_at', 'updated_at']

    text     : -> @morphOne Text, 'textable'
    likes    : -> @morphMany User, 'likeable'
    category : -> @belongsTo Category
    user     : -> @belongsTo User
    replies  : -> @hasMany Reply
