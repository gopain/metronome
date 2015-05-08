module.exports = (table) ->
  table.increments()
  table.integer('user_id').index()
  table.boolean('read').defaultTo(false)
  table.text('content')
  table.timestamp('created_at')
