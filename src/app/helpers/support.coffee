module.exports = (server) ->
  calculateScore: (count, hourAge, gravity) ->
    gravity = gravity or 1.8
    (count - 1) / Math.pow(hourAge + 2, gravity)

  # calculateScore(10, diffInHours(topic.updated_at - topic.created_at))

  setTimezone: (timezone) ->
    "Asia/Shanghai"
