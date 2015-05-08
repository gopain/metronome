module.exports = (validator, input) ->
  file =
    messages: []

  if input
    file.size = input.size
    file.name = input.name
    file.mime_type = input.mimetype
    file.extension = input.extension
  else
    file.messages.push('%{file} should not be empty')

  file
