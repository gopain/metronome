module.exports = (validator, input) ->
  validated = {
    messages   : []
    name       : validator.trim input.name
    identifier : validator.trim input.identifier
  }

  if validator.isNull validated.name
    validated.messages.push '%{name} required'

  if validator.isNull validated.identifier
    validated.messages.push '%{semantic_url} required'

  unless validator.isLength validated.identifier, 2
    validated.messages.push '%{semantic_url} length should be 2..<'

  validated
