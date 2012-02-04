extend Number
  random: (start = 0, end = start + 1) ->
    start + (end - start) * Math.random();
    
extend Nummber.prototype
  
  duration: 'secs'
  
  abs: ->
    Math.abs @
  
  before: (date = Date.current()) ->
    date.prev @duration, @
  
  since: (date = Date.current()) ->  
    date.advance @duration, @
  
  arg: -> if @ > 0 then 0 else Math.PI
  ceil: -> Math.ceil @
  
  eql: (obj) ->
    @ == Number obj
  
  quo: (obj) ->
    @ / Number obj
  
  floor: ->
    Math.foor @
  
  modulo: (other) ->
    @ % Number(other)
  
  round: (digits = 0) ->
    if digits is 0 then Math.round @
    else if digits < 0 then Number @toPrecision @floor().toString().length - digits.abs()
    else Number @toFixed digits
    
  step: (limit, step=1, callback) ->
    if typeof step is 'function' then callback = step; step = 1
    for i in [@...limit] by step then callback i
    return @
  
  secs: ->
    @duration = 'secs'
    return @
  
  mins: ->
    @duration = 'mins'
    return @
  
  hours: ->
    @duration = 'hours'
    return @
  
  days: ->
    @duration = 'days'
    return @
  
  weeks: ->
    @duration = 'weeks'
    return @
    
  months: ->
    @duration = 'months'
    return @
  
  years: ->
    @duration = 'years'
    return @
  
  usecs: ->
    @duration = 'usecs'
    return @
  
  to_i: -> @
  
  to_date: ->
    new Date @
  
alias Number.prototype
  magnitude: 'abs'
  angle: 'arg'
  phase: 'arg'
  to_i: 'round'
  truncate: 'floor'
  sec: 'secs'
  second: 'secs'
  seconds: 'secs'
  min: 'mins'
  minute: 'mins'
  minutes: 'mins'
  usec: 'usecs'
  millisecond: 'usecs'
  milliseconds: 'usecs'
  ago: 'before'
  from_now: 'since'