module.exports = (path) ->
  knex =
    development:
      client: 'sqlite3'
      connection:
        filename: './development.sqlite'
    production:
      client: 'postgresql'
      connection:
        database: 'metronome_production'
        password: 'password'
        user: 'root'
      pool:
        min: 2
        max: 10
      migrations:
        tableName: 'knex_migrations'
