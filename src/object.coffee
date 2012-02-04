

extend Object
  
  clone: (obj) ->
  
  hash$: (obj) ->
    extend obj
      size: -> Object.size @
      keys: -> Object.keys @
      each: (callback) -> Object.each @, callback
      map: (callback) -> Object.map @, callback
      map$: (callback) -> Object.map$ @, callback
      reduce: (callback, initial) -> Object.reduce @, callback, initial
      filter: (callback) -> Object.filter @, callback
      filter$: (callback) -> Object.filter$ @, callback
      clean: (callback) -> 