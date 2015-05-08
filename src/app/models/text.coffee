module.exports = (bookshelf) ->
  bookshelf.Model.extend
    tableName: 'texts'
    hasTimestamps: ['updated_at']

    textable: -> @morphTo 'textable'
