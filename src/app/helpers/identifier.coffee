module.exports = (value) ->
  identifier = new (require 'hashids') '2015-03-27', 20, '0123456789abcdef'

  if typeof value is 'number'
    identifier.encode(value)
  else
    identifier.decode(value)[0]
