module.exports = (table) ->
  table.increments()
  table.integer('user_id').index()
  table.integer('reply_id').index()
  table.boolean('reversed').defaultTo(false)
