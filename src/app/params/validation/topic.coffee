module.exports = (validator, input) ->
  validated = {
    messages   : []
    categoryId : input.category_id
    title      : validator.trim input.title
    body       : validator.trim input.body
  }

  unless validator.isNumeric validated.categoryId
    validated.messages.push '%{category_id} should be numberic'

  if validator.isNull validated.title
    validated.messages.push '%{title} required'

  validated
