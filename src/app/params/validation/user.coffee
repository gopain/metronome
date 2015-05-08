module.exports = (validator, input) ->
  reserved = 'notification:notifications:setting:settings:assets:fonts:popular:use'.split ':'
    .concat 'category:categories:topic:topics:reply:replies:tag:tags:users:user:io'.split ':'
    .concat 'relation:relations:followers:following:unfollow:follow:username:index'.split ':'
    .concat 'blog:explore:trending:search:login:logout:signup:super:admin:password'.split ':'
    .concat 'file:files:image:images:event:events:like:likes:vote:votes:star:stars'.split ':'

  validated = {
    messages : []
    username : validator.trim input.username
    password : validator.trim input.password
    email    : validator.trim(input.email).toLowerCase()
  }

  if validator.isNull validated.username
    validated.messages.push '%{username} required'

  if validator.isNull validated.password
    validated.messages.push '%{password} required'

  if validator.isNull validated.email
    validated.messages.push '%{email} required'

  unless validator.isLength validated.username, 2, 32
    validated.messages.push '%{username} length should be 2..32'

  unless validator.matches validated.username, /^[A-Za-z-][_A-Za-z0-9]{1,32}$/
    validated.messages.push '%{username} format'

  if validator.isIn validated.username, reserved
    validated.messages.push '%{username} not allowed'

  unless validator.isEmail validated.email
    validated.messages.push '%{email} should be a real email'

  unless validator.isLength validated.password, 6, 72
    validated.messages.push '%{password} should be 6..72'

  unless validator.matches validated.password, /^[A-Za-z0-9-_\.]+$/
    validated.messages.push '%{password} should be _*.'

  validated
