module.exports = (table) ->
  table.increments()
  table.integer('user_id').index()
  table.integer('category_id').index()
  table.string('title')
  table.string('identifier')
  table.string('last_replied_by')
  table.integer('replies_count').defaultTo(0)
  table.integer('likes_count').defaultTo(0)
  table.integer('views_count').defaultTo(1)
  table.float('ranking').defaultTo(0.0)
  table.timestamp('blocked_at')
  table.timestamp('deleted_at')
  table.timestamps()