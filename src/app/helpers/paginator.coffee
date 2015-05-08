module.exports = (currentPage, perPage) ->
  perPage = perPage || 20

  currentPage = Math.abs(currentPage)
  currentPage = if isNaN(currentPage) then 1 else currentPage or 1
  offsetValue = (currentPage - 1) * perPage

  perPage      : perPage
  currentPage  : currentPage
  offsetValue  : offsetValue
  queryBuilder : (qb) -> qb.limit(perPage).offset(offsetValue)
