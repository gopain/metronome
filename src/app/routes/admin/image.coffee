module.exports = (bookshelf, config) ->
  index: ->
    yield @render 'admin/image/index'

  # Image = require('../../models/image')(bookshelf)
  # fs = require('fs')
  # gm = require('gm')

  # index: (request, response, next) ->
  #   Image.where({ user_id: 'request.user.id' }).fetchAll().then (images) ->
  #     response.render 'backend/image/index.jade',
  #       images: images.toJSON()

  # store: (request, response, next) ->
  #   response.set 'Content-Type', 'application/javascript'
  #   image = params.validate(request.files.image)
  #   if image.permitted
  #     image =
  #       name: image.name
  #       user_id: request.user.id
  #       imageable_id: request.user.id
  #       imageable_type: 'users'

  #     new Image(image).save().then (image) ->
  #       name = image.get 'name'
  #       path = "public_path/files/#{name}"
  #       fs.exists path, (exists) ->
  #         unless exists
  #           return { exists: false }
  #         gm(path).size (error, size) ->
  #           unless error
  #             min = Math.min(size.width, size.height, 560)
  #             @gravity('Center').resize(min, min, '^>').crop(min, min).write image_path, (error) ->
  #               response.send 'location.pathname = "/admin/image";'
  #   else
  #     fs.unlinkSync image.path if image.path
  #     response.send 'console.log("")'

  # destroy: (request, response, next) ->
  #   response.send 'Content-Type', 'application/javascript'
  #   new Image({ id: request.param('id') }).fetch().then (image) ->
  #     unless image
  #       return response.send ''

  #     name = image.get('name')
  #     file = ''

  #     fs.exists file, (exists) ->
  #       unless exists
  #         return { exists: false }
  #       fs.unlinkSync(files)
  #       fs.unlinkSync imageFile if fs.existsSync imageFile

  #     new Image({ id: image.id }).destroy().then ->
  #       response.send '$(".image.index li[data-image-id=' + image.id + ']").fadeOut(200);'
