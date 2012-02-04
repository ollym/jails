extend String.prototype
  to_i: -> parseInt(@) or 0
  to_s: -> @
  to_hash: ->
    Object.Hash JSON.parse @