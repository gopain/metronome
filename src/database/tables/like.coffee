module.exports = (table) ->
  table.increments()
  table.integer('user_id').index()
  table.integer('topic_id').index()
