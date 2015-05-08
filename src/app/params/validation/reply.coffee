module.exports = (validator, input) ->
  validated = {
    messages : []
    topicId  : input.topic_id
    content  : validator.ltrim input.content
  }

  [limitation, mentions] = [3, new Array]

  if validator.isNull validated.topicId
    validated.messages.push '%{topic_id} required'

  if validator.isNull validated.content
    validated.messages.push '%{content} required'

  unless validator.isNumeric validated.topicId
    validated.messages.push '%{topic_id} should be numberic'

  # matches = validated.content.match /@[\w]{2,18}\s/g

  # if matches
  #   for matched in matches
  #     value = matched.replace '@', ''
  #     downcase = value.trim().toLowerCase()
  #     if mentions.indexOf(downcase) is -1
  #       if mentions.length < limitation
  #         mentions.push downcase

  # validated.content = validated.content.replace /@([\w]{2,18})\s/g, '<a href="/$1">@$1</a>'
  # validated.mentions = mentions

  validated
