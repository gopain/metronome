module.exports = (path, root) ->
  path: {
    app     : path.join root, 'src', 'app'
    assets  : path.join root, 'src', 'app', 'assets'
    helpers : path.join root, 'src', 'app', 'helpers'
    models  : path.join root, 'src', 'app', 'models'
    params  : path.join root, 'src', 'app', 'params'
    routes  : path.join root, 'src', 'app', 'routes'
    views   : path.join root, 'src', 'app', 'views'
    config  : path.join root, 'src', 'config'
    i18n    : path.join root, 'src', 'i18n'
    test    : path.join root, 'src', 'test'
    index   : path.join root, 'src', 'index'
    server  : path.join root, 'src', 'server'
    tables  : path.join root, 'src', 'database', 'tables'
    static  : path.join root, 'static'
    files   : path.join root, 'static', 'files'
  }

  i18n: {
    locales        : 'zh|ko|us'.split '|'
    directory      : path.join root, 'src', 'i18n'
    defaultLocale  : 'zh'
    objectNotation : true
    updateFiles    : false
  }

  keys: [process.env.SECRET_KEY or '5f21ee51251b80b5ab859cb44e212a710daaf698e3177bda004441c0e9e513d9726a09858ac553d5bb053e085d228bd81bef6575687cc4ac43d1b59f8afe3239']

  knex: (require path.join __dirname, 'knex') path

  view: { default: 'jade', map: { html: 'mustache' } }

  _method: (request, response) ->
    if request.body and typeof request.body is 'object' and '_method' of request.body
      method = request.body._method
      delete request.body._method
      method
