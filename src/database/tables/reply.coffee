module.exports = (table) ->
  table.increments()
  table.integer('user_id').index()
  table.integer('topic_id').index()
  table.integer('favourer_count').defaultTo(0)
  table.integer('objectors_count').defaultTo(0)
  table.boolean('trashed').defaultTo(false)
  table.text('content')
  table.timestamps()
