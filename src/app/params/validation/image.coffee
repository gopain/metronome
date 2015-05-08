module.exports = (validator, input) ->
  image =
    messages: []

  limitation = 1024 * 1024 * 10
  mimeTypes = ['image/png', 'image/jpeg']

  if input
    image.name = input.name
    image.path = input.path
    image.size = input.size
    if image.size > limitation
      image.messages.push('%{image} size should less than ' + limitation.toString())

    unless validator.isIn(image.mimetype, mimeTypes)
      image.messages.push('%{image} mimetype not supported')
  else
    image.messages.push('%{file} should not be empty')
