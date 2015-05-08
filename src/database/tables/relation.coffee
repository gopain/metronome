module.exports = (table) ->
  table.increments()
  table.integer('follower_id').index()
  table.integer('followed_id').index()
