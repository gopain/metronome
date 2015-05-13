module.exports = (router, bookshelf, config) ->
  admin =
    home  : (require "#{config.path.routes}/admin/home") bookshelf, config
    user  : (require "#{config.path.routes}/admin/user") bookshelf, config
    topic : (require "#{config.path.routes}/admin/topic") bookshelf, config
    category: (require "#{config.path.routes}/admin/category") bookshelf, config
    image: (require "#{config.path.routes}/admin/image") bookshelf, config
    tag: (require "#{config.path.routes}/admin/tag") bookshelf, config

  for_topic =
    likeable : (require "#{config.path.routes}/for_topic/likeable") bookshelf, config
    sortable : (require "#{config.path.routes}/for_topic/sortable") bookshelf, config

  as_user =
    activity : (require "#{config.path.routes}/as_user/activity") bookshelf, config
    relation : (require "#{config.path.routes}/as_user/relation") bookshelf, config
    password : (require "#{config.path.routes}/as_user/password") bookshelf, config
    profile  : (require "#{config.path.routes}/as_user/profile") bookshelf, config
    avatar   : (require "#{config.path.routes}/as_user/avatar") bookshelf, config

  passport =
    github : (require "#{config.path.routes}/passport/github") bookshelf, config

  session = (require "#{config.path.routes}/session") bookshelf, config
  message = (require "#{config.path.routes}/message") bookshelf, config
  topic   = (require "#{config.path.routes}/topic") bookshelf, config
  reply   = (require "#{config.path.routes}/reply") bookshelf, config
  home    = (require "#{config.path.routes}/home") bookshelf, config
  user    = (require "#{config.path.routes}/user") bookshelf, config

  router
    .get  '/'         , home.index
    .get  '/login'    , session.new
    .get '/signup'    , user.new
    .post '/user', user.store
    .delete '/logout', session.destroy
    .get '/search'    , for_topic.sortable.search
    .get '/popular', for_topic.sortable.popular
    .get '/category/:identifier', for_topic.sortable.category
    .get '/topic/new' , topic.new
    .post '/topic', topic.store
    .get '/topic/:id', topic.show
    .get '/topic/:id/edit', topic.edit
    .patch '/topic/:id', topic.update
    .get '/topic/:id/likeable', for_topic.likeable.index
    .post '/topic/:id/like', for_topic.likeable.store
    .delete '/topic/:id/unlike', for_topic.likeable.destroy
    .get '/replies', reply.index
    .post '/reply', reply.store
    .get '/reply/:id', reply.show
    .delete '/reply/:id', reply.destroy
    .get '/setting/profile', as_user.profile.edit
    .get '/notification', message.index
    .delete '/notification/:id', message.destroy
    .get '/password/new', as_user.password.new
    .get '/password/store', as_user.password.store
    .get '/password/:token', as_user.password.edit
    .post '/password', as_user.password.store
    .patch '/password', as_user.password.update
    .post '/setting/avatar', as_user.avatar.store
    .get '/passport/github', passport.github.new
    .get '/passport/github/authorize', passport.github.store
    .get '/admin'     , admin.home.index
    .get '/admin/users', admin.user.index
    .get '/admin/topics' , admin.topic.index
    .delete '/admin/topic/:id', admin.topic.destroy
    .get '/admin/categories', admin.category.index
    .get '/admin/category/new', admin.category.new
    .get '/admin/category/:id/edit', admin.category.edit
    .post '/admin/category', admin.category.store
    .patch '/admin/category/:id', admin.category.update
    .delete '/admin/category/:id', admin.category.destroy
    .get '/admin/images', admin.image.index
    .get '/admin/tags', admin.tag.index
    .get '/:username', user.show
    .get '/:username/activity', as_user.activity.index
    .get '/:username/following', as_user.relation.following
    .get '/:username/followers', as_user.relation.followers
