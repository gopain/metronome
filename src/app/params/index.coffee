module.exports = (model, config) ->
  validate = require "#{config.path.params}/validation/#{model.toLowerCase()}"

  validated =
    validate: (input) ->
      validated = validate (require 'validator'), input
      validated.permitted = ! validated.messages.length
      validated
