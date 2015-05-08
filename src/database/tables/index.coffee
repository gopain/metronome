module.exports = (knex, config, path) ->
  table =
    tags          : require path.join __dirname, 'tag'
    likes         : require path.join __dirname, 'like'
    texts         : require path.join __dirname, 'text'
    users         : require path.join __dirname, 'user'
    votes         : require path.join __dirname, 'vote'
    events        : require path.join __dirname, 'event'
    topics        : require path.join __dirname, 'topic'
    replies       : require path.join __dirname, 'reply'
    relations     : require path.join __dirname, 'relation'
    taggables     : require path.join __dirname, 'taggable'
    categories    : require path.join __dirname, 'category'
    notifications : require path.join __dirname, 'notification'

  knex.schema.dropTableIfExists 'tags'
    .exec (error) ->
  knex.schema.dropTableIfExists 'likes'
    .exec (error) ->
  knex.schema.dropTableIfExists 'texts'
    .exec (error) ->
  knex.schema.dropTableIfExists 'users'
    .exec (error) ->
  knex.schema.dropTableIfExists 'votes'
    .exec (error) ->
  knex.schema.dropTableIfExists 'events'
    .exec (error) ->
  knex.schema.dropTableIfExists 'topics'
    .exec (error) ->
  knex.schema.dropTableIfExists 'replies'
    .exec (error) ->
  knex.schema.dropTableIfExists 'relations'
    .exec (error) ->
  knex.schema.dropTableIfExists 'taggables'
    .exec (error) ->
  knex.schema.dropTableIfExists 'categories'
    .exec (error) ->
  knex.schema.dropTableIfExists 'notifications'
    .exec (error) ->

  knex.schema.createTable 'tags', table.tags
    .then ->
      knex.schema.createTable 'likes', table.likes
    .then ->
      knex.schema.createTable 'texts', table.texts
    .then ->
      knex.schema.createTable 'users', table.users
    .then ->
      knex.schema.createTable 'votes', table.votes
    .then ->
      knex.schema.createTable 'events', table.events
    .then ->
      knex.schema.createTable 'topics', table.topics
    .then ->
      knex.schema.createTable 'replies', table.replies
    .then ->
      knex.schema.createTable 'relations', table.relations
    .then ->
      knex.schema.createTable 'taggables', table.taggables
    .then ->
      knex.schema.createTable 'categories', table.categories
    .then ->
      knex.schema.createTable 'notifications', table.notifications
    .then ->
      process.exit 0
