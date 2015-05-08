module.exports = (table) ->
  table.increments()
  table.integer('textable_id').index()
  table.string('textable_type', 100).index()
  table.text('source')
  table.text('html')
  table.timestamp('updated_at')
