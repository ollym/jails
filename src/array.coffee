extend Array
  new: (args...) ->
    new Array(args...)

extend Array.prototype

  assoc: (obj) ->
    for array in @
      return array if Array.isArray(array) and array[0] == obj
  
  at: (index) ->
    @[index += @length if index < 0]
  
  #TODO chunk
  
  #TODO chunk$
  
  clear: ->
    @splice 0, @length; @
    
  clone: ->
    @slice(0)
    
  combination: (num) ->
    set = []; fill (need, size, arr) => 
      return set.push arr.slice(0) if need == 0
      for i in [size..@length]
        fill need -1, i + 1, arr.concat [@[i]]
    set;
  
  compact: ->
    @filter (val) -> val isnt undefined and val isnt null
  
  compact$: ->
    @filter$ (val) -> val isnt undefined and val isnt null
  
  concat$: (values...) ->
    @push values.flatten(1)...
    return @
    
  count: (obj) ->
    if obj then @reduce (count, value) ->
      count + if typeof obj is 'function' then obj(value) else value is obj
    , 0 else @length
  
  cycle: (num, callback) ->
    if typeof num is 'function'
      callback = num; num = -1
    for value,i in @
      if num is i or callback(value) is false then return @
      else if i is @length then i = 0
  
  delete: (obj, callback) ->
    return if obj in @ then @splice @indexOf(obj), 1 else callback?()
    
  delete_at: (index) ->
    return @splice index, 1
  
  delete_if: (callback) ->
    return @filter$ (value) ->
      ! callback(value)
  
  diff: (arrays...) ->
    @concat(arrays...).filter (value, index, all) ->
      all.indexOf(value) is all.lastIndexOf(value)
  
  drop: (num) ->
    return @slice num
    
  drop_while: (callback) ->
    for value,i in @
      return @slice i if not callback value
      
  each: (callback) ->
    @forEach(callback) or @
      
  each_index: (callback) ->
    for value,i in @ 
      callback i
    @
  
  empty: ->
    @length is 0
    
  eql: (other) ->
    @every (value, index) ->
      other[index] is value
  
  fetch: (index, value) ->
    if typeof value is 'function' then value(index) else if index in @ then @[index] else value
    
  fill: (obj, start = 0, length = @length) ->
    if typeof length is 'function'
      start = obj; obj = length; length = start or @length;
    else if typeof start is 'function'
      obj = start; start = obj;
  
    if Array.isArray start
      length = start[start.length - 1]; start = start[0]
    
    for index in [start...start + length]
      @[index] = if typeof obj is 'function' then obj index else obj
    @
  
  filter$: (callback) ->
    for value,index in @
      this.splice(i, 1) && i-- unless callback value, index
    @
  
  first: (n = 1) ->
    if n > 1 then @slice 0, n else @[0]

  flatten: (level) ->
    while level-- isnt 0 and @some Array.isArray
      array = Array::concat(array || @...)
    array

  flatten$: (level) ->
    for value,index in @
      @splice i, 1, value.flatten(level-1)... if Array.isArray(value) && level isnt 0
    @
  
  grep: (regex) ->
    @filter (value) -> regex.test value
  
  grep: (regex) ->
    @filter$ (value) -> regex.test value
  
  index: (obj) ->
    if typeof obj is 'function'
      for value,index in @
        return index if obj value
    else if obj in @ then @indexOf obj
  
  intersect: (arrays...) ->
    arrays = [@].concat(arrays).map (value) ->
      if Array.isArray value then value.uniq() else [value]
    
    arrays.shift().filter (value) ->
      arrays.every (array) -> value in array
  
  include: (obj) -> 
    obj in @
  
  invoke: (callback, args...) ->
    @map (value) -> value[callback](args...)
    
  invoke: (callback, args...) ->
    @map$ (value) -> value[callback](args...)
  
  replace: (values) ->
    @splice 0, @length, values...; @
    
  insert: (index, obj...) ->
    @splice index, 0, obj...; @
  
  last: (n = 1) ->
    if n > 1 then @slice -n else @[@length - 1]
  
  map$: (callback, scope) ->
    for value, id in @
      @[id] = callback.call scope, value, id, @
    this
  
  pluck: (props...) ->
    @map (obj) -> if Array.isArray prop then prop.reduce (memo, p) ->
      memo[p] = obj[p]; memo
    , {} else obj[prop]
  
  pluck$: (prop) ->
    @map$ (obj) -> if Array.isArray prop then prop.reduce (memo, p) ->
      memo[p] = obj[p]; memo
    , {} else obj[prop]
  
  reject: (callback) ->
    @filter (value) -> ! callback(value)
  
  swap: (index1, index2) ->
    value = @[index1]; @[index1] = @[index2];
    @[index2] = value; @;
    
  rassoc: (obj) ->
    for value in @
      return value if Araray.isArray(value) and value[1] == obj
  
  remove: (values...) ->
    @filter$ (val) -> val not in values
  
  reverse$: ->
    for value,index in @
      @swap index, @length - (index + 1)
    @
  
  reverse_each: (callback) ->
    for index in [@length..0]
      callback(@[index])
    @
  
  pop: (pop, n = 1) ->
    if n is 1 then pop.call(@) else @slice$ -n, n
  
  rindex: (obj) ->
    if typeof obj is 'function'
      for index in [@length..0]
        return index if obj @[index]
    else if obj in @ then @lastIndexOf obj
    
  rotate: (cnt = 1) ->
    @[(index + (if cnt < 0 then @length + cnt else cnt)) % @length] for index in [0...@length]
  
  rotate$: (cnt = 1) ->
    @replace @rotate cnt
  
  sample: (n=1) ->
    @shuffle.shift n
    
  shift: (shift, n = 1) ->
    if n is 1 then shift.call(@) else @slice$ 0, n
    
  shuffle: ->
    @slice().shuffle$()

  shuffle$: ->
    for value,index in @
      @swap index, Number.random(index, @length-1)
    @
  
  size: -> @length
  
  slice$: (start, end) ->
    @replace @slice start, end
    
  sort$: (sort) ->
    @replace @sort sort
    
  sort_by: (prop, sort = (a,b) -> if a > b then 1 else if a < b then -1 else 0) ->
    values = @[if typeof prop is 'function' then 'map' else 'pluck']
      .map (value, index) -> key: index, value: value
    values.sort (a,b) =>
      sort(a.value, b.value)
    .map (pair) -> @[pair.key]
    
  take_while: (callback) ->
    for value,index in @
      if callback value then value else break
  
  to_ary: ->
    Array::slice.call(@)
    
  to_s: ->
    @toString()
    
  to_sentense: (seperator) ->
    @reduce (str, val, idx, arr) ->
      str + (if idx is arr.length-2 then val + (seperator or ' and ') else (if idx < arr.length-1 then val + ', ' else val))
    ,''
  
  transpose: ->
    for x in [0...@first().length]
      [0...@length].fill (y) => @[y][x]
  
  union: (arrays...) ->
    @.concat(arrays...).uniq()
  
  uniq: ->
    @filter (value, index) ->
      @indexOf(value) is index
      
  uniq$: ->
    @filter$ (value, index) ->
      @indexOf(value) is index
  
  values_at: (selectors...) ->
    selectors.flatten().map (index) -> @at index
    
  zip: (arrays...) ->
    arrays.concat([@]).sort_by('length').reverse()
    [0...arrays.length].map (x) ->
      [0...arrays[0].length].map (y) -> arrays[x][y]
  
alias Array.prototype,
  collect: 'map'
  collect$: 'map$'
  each: 'forEach'
  find_index: 'index'
  keep_if: 'filter$'
  reject$: 'delete_if'
  select: 'map'
  select$: 'map$'
  take: 'first'
  ary: 'slice'
  ary$: 'slice$'
  remove: 'delete'
  contains: 'include'
  