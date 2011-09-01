String::extractPercent = ->
  parseInt(@slice(0, @indexOf("%")), 10)
