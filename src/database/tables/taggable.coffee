module.exports = (table) ->
  table.increments()
  table.integer('tag_id').index()
  table.integer('taggable_id').index()
  table.string('taggable_type', 100).index()
