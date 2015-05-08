module.exports = (bookshelf, config) ->
  User     = (require "#{config.path.models}/user") bookshelf
  Topic    = (require "#{config.path.models}/topic") bookshelf, User
  Reply    = (require "#{config.path.models}/reply") bookshelf, User, Topic

  identify = (require "#{config.path.helpers}/identifier")
  paginate = (require "#{config.path.helpers}/paginator")
  sanitize = (require "#{config.path.helpers}/sanitizer")
  markdown = (require "#{config.path.helpers}/markdown")

  params = (require config.path.params) 'Reply', config

  index: ->
    yield `function*(){}`
    @body = {}

  store: ->
    reply = params.validate @request.body

    unless reply.permitted
      return @body = { permitted: false }

    topic = yield Topic.forge({ id: 1 }).fetch().exec (error, topic) ->

      # new Reply(
      #   user_id  : request.user.get('id')
      #   topic_id : topic.get('id')
      #   content  : reply.content
      # ).save().then (reply) ->
      #   response.set 'Content-Type', 'application/javascript'
      #   response.send '{}'

          # replied =
          #   user_id: topic.get('user_id')
          #   content: 'someone reply your topic'

          # knex.select('id').from('users').whereIn('downcase', form.mentions).then (users) ->
          #   notifications = []
            # users.forEach(function(user){
            #   if (request.user.id != user.id) {
            #     notifications.push({ user_id: user.id, content: '@you' });
            #   }
            # });
            # if (replied.user_id != request.user.get('id')) {
            #   notifications.push(replied);
            # }

          #   knex('notifications').insert(notifications).exec ->

    @body = {}

  show: ->
    yield `function*(){}`
    @body = {}

    # unless request.xhr
    #   return response.render '404.jade'

    # new Reply({ id: request.param('id') }).fetch({ withRelated: ['user'] }).then (reply) ->
    #   response.render 'reply/show.jade',
    #     reply: reply.toJSON()

  destroy: ->
    yield `function*(){}`
    @body = {}

    # replyId = request.param('id')
    # Reply.where({ id: replyId, user_id: request.user.get('id') }).destroy().then ->
    #   response.set 'Content-Type', 'application/javascript'
    #   response.send "$('.reply li[data-reply-id=" + replyId + "]').fadeOut(200);"
