module.exports = (bookshelf, config) ->
  User = (require "#{config.path.models}/user") bookshelf

  index: (next) ->
    yield next if next
    @redirect '/setting/profile'

  edit: ->
    yield @render 'user/profile/edit'

#   update: (request, response, next) ->
#     # flash: updated
#     Profile.where({ user_id: request.user.id }).fetch().then (profile) ->
#       _profile =
#         nickname:    request.body.nickname
#         location:    request.body.location
#         website_url: request.body.website_url
#         school:      request.body.school

#       new Profile({ id: profile.id }).save(_profile, { patch: true }).then ->
#         response.redirect '/setting/profile'
