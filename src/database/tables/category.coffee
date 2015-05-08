module.exports = (table) ->
  table.increments()
  table.string('identifier').index()
  table.string('name', 100)
  table.text('description')
  table.integer('topics_count').defaultTo(0)
  table.timestamps()
