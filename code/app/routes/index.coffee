module.exports = (app, routes) ->
  app.get '/relation', user.relation.show
  app.post '/follow', user.relation.store
  app.delete '/unfollow', user.relation.destroy

  app.get '/setting', as_user.profile.index
  app.get '/setting/avatar', as_user.avatar.index
  app.post '/setting/avatar', as_user.avatar.store
  app.get '/setting/profile', as_user.profile.edit
  app.put '/setting/profile', as_user.profile.update
  app.get '/setting/password', as_user.password.edit
  app.put '/setting/password', as_user.password.update

  app.get('/api/likeable', as_api.likeable.index)

  app.get('/likes', topic.sorted.likes)
  app.get('/replies', topic.sorted.replies)
  app.post('/topic/:id/subscribe')
  app.delete('/topic/:id/unsubscribe')

  orderBy('id', 'desc')
  knex('website_settings').first().then (setting) ->
    setting = setting or {}
  knex('website_settings').where({ id: params.id }).update(setting).then ->
  knex('website_settings').insert(setting).then ->

  # 'followed'         : '开始关注你',
  # 'mentioned'        : '在回复主题 :topic 中提及了你',
  # 'watching_replied' : '回复了你关注的主题 :topic',
  # 'topic_watched'    : '开始关注你的主题 :topic',
  # 'topic_replied'    : '回复了你的主题 :topic',
  # 'topic_liked'      : '赞了你的主题 :topic',

  # reminder.expire = 60

module.exports = (bookshelf) ->
  File = require('../../models/file')(bookshelf)
  fs = require('fs')

  index: (request, response, next) ->
    new File().fetchAll().then (files) ->
      response.render 'backend/file/index.jade', { files: files.toJSON() }

  store: (request, response, next) ->
    file = params.validate(request.body)
    response.set('Content-Type', 'application/javascript');
    if file.permitted
      file = file.only(['size', 'name', 'mime_type', 'extension'])
      file.user_id = request.user.id
      new File(file).save().then ->
        response.send 'location.pathname = "/admin/file";'
    else
      response.send 'console.log("")'

  destroy: (request, response, next) ->
    response.set('Content-Type', 'application/javascript')
    new File({ id: request.param('id') }).fetch().then (file) ->
      path = request.files_path + file.get('name')
      fs.unlinkSync path if fs.existsSync path
      new File({ id: file.get('id') }).destroy().then ->
        response.send 'location.pathname = "/admin/file";'
