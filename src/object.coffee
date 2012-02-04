class Object.Hash
  
  @new: (object = {}) ->
    new Object.Hash object
    
  constructor: (object = {}) ->
    if @ instanceof Object.Hash then @replace object else new Object.Hash object
  
  assoc: (key) ->
    [key, @[key]]
  
  clear: ->
    for own key of @ then delete @[key]
    return @
    
  clone: ->
    new Object.Hash
  
  delete: (key) ->
    delete @[key]
    
  delete_if: (callback) ->
    for own key,value of @
      delete @[key] if callback key, value
    return @
  
  each: (callback) ->
    @keys().forEach (key) ->
      callback key, @[key]
    return @
    
  each_key: (callback) ->
    @keys().forEach callback
    return @
  
  each_value: (callback) ->
    @keys().forEach (key) ->
      callback @[key]
    return @
  
  empty: ->
    @size() is 0
  
  eql: (other) ->
    @size() is @size(other) and 
      @every (key, value) ->
        other[key] is value
  
  every: (callback) ->
    @keys().every (key) ->
      callback key, @[key]
      
  fetch: (key, def) ->
    if @has_name key then @[key] else
      if typeof def is 'function' then def key else def
  
  flatten: (level = 1) ->
    @reduce((array, key, value) ->
      array.concat key, value
    , []).flatten level
  
  has_name: (key) ->
    @hasOwnProperty key
  
  has_key: (key) ->
    @has_name(key) and @propertyIsEnumerable key
    
  has_value: (value) ->
    for own key,val of @
      return true if val is value
    return false
  
  to_json: (replacer, space) ->
    JSON.stringify @, replacer, space
    
  to_a: ->
    @keys().reduce (array, key) ->
      array.concat [[key, @[key]]]
    , []
  
  to_hash: -> @valueOf()
  
  inspect: ->
    @toString()
  
  invert: ->
    @reduce @, (key, value) ->
      @[value] = key; @
    , {}
  
  keep_if: (callback) ->
    @each (key, value) ->
      delete @[key] if callback key, value
    return @
  
  key: (value) ->
    for own key,val of @
      return key if val is value
  
  keys: ->
    Object.keys @
  
  names: ->
    Object.getOwnPropertyNames @
  
  size: ->
    @keys().length
  
  merge: (other, callback) ->
    @merge$ @clone(), other, callback
  
  merge$: (other, callback) ->
    for own key,value of other
      @[key] = if typeof callback is 'function'
        callback(key, @[key], value)
      else value
  
  rassoc: (key) ->
    if @has_name key then [key, @[key]]
  
  reject: (callback) ->
    @filter (key, value) ->
      ! callback(key, value)
    
  reject$: (callback) ->
    length = @size()
    @delete_if callback
    return @ if length is @size()

  replace: (other) ->
    @clear()
    @each other, (key, value) ->
      @[key] = value
    return @
    
  select: (callback) ->
    @keys().reduce (obj, key) ->
      obj[key] = @[key] if callback(key, @[key]); obj
    , {}  
  
  select$: (callback) ->
    length = @size()
    @keep_if callback
    return @ if length is @size()
  
  shift: ->
    key = @keys()[0]; value = @[key];
    delete @[key]; [key, value];
  
  values: ->
    @values_at @keys()...
    
  values_at: (keys...) ->
    keys.map (key) -> @[key]

alias Object.Hash
  each_pair: 'each'
  include: 'has_key'
  key: 'has_key'
  member: 'has_key'
  json: 'to_json'
  filter$: 'keep_if'
  length: 'size'
  update: 'merge'
  update$: 'merge$'
  filter: 'select'
  to_s: 'inspect'
  value: 'has_value'
  dup: 'clone'

# Prototype methods
extend Object

  clone: (object, inherit = true) ->
    Object.create Object.prototoype(object), if inherit 
      Object.names(object).map (key) -> Object.descriptor object, key
    else null
    
  descriptors: ->
    @names().reduce (descriptors, name) ->
      descriptors[name] = @descriptor name; descriptors
    , {}

alias Object
  descriptors: 'getOwnPropertyDescriptor'
  names: 'getOwnPropertyNames'

###
        
###

polyfill Object
  