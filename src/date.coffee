extend Date

  new: (args...) ->
    if typeof parseInt(args[2]) is 'number' then args[2]--;
    new Date(args...)
  
  DATE_FORMATS:
    foo: 'bar'
  
  ABBR_DAYNAMES:
    ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
  
  ABBR_MONTHNAMES:
    [null, 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  
  DAYNAMES:
    ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  
  MONTHNAMES:
    [null, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
  
  DEFAULT_LOCALE: 'en-us'
  
  #TODO: Get locales working
  STRFTIME_LOCALES:
    en: #en-gb, en-au etc.
      c: (date) -> "#{@a date} #{@d date} #{@b date} #{@Y date} #{@T date} #{@Z date}"
      D: (date) -> "#{@d date}/#{@m date}/#{@y date}"
      x: (date) -> @D d
      X: (date) -> @T d
    'en-us':
      c: (date) -> "#{@a date} #{@d date} #{@b date} #{@Y date} #{@r date} #{@Z date}"
      x: (date) -> @D date
      X: (date) -> @r date

  STRFTIME_FORMATS:
    a: (date) -> Date.ABBR_DAYNAMES[date.wday()]
    A: (date) -> Date.DAYNAMES[date.wday()]
    b: (date) -> Date.ABBR_MONTHNAMES[date.mon()]
    B: (date) -> Date.MONTHNAMES[date.mon()]
    c: (date) -> "#{@a date} #{@b date} #{@e date} #{@T date} #{@Y date}"
    C: (date) -> (Math.floor date.year() / 100)
    d: (date, flags, width=2) -> date.day().to_s().rjust width, if '_' in flags then ' ' else '0'
    D: (date) -> "#{@m date}/#{@d date}/#{@y date}"
    e: (date, flags, width=2) -> date.day().to_s().rjust width, if '0' in flags then '0' else ' '
    F: (date) -> "#{@Y date}-#{@m date}-#{@d date}"
    g: (date, flags, width=2) -> date.cwyear().to_s().substr(2).rjust width, if '_' in flags then ' ' else '0'
    G: (date) -> date.cwyear()
    h: (date) -> @b date
    H: (date, flags, width=2) -> date.getHours().to_s().rjust width, if '_' in flags then ' ' else '0'
    I: (date, flags, width=2) -> (@l date).rjust width, if '_' in flags then ' ' else '0'
    j: (date, flags, width=3) -> date.yday().to_s().rjust width, if '_' in flags then ' ' else '0'
    k: (date, flags, width=2) -> date.getHours().to_s().rjust width, if '0' in flags then '0' else ' '
    l: (date) -> l = date.getHours() % 12; (if l is 0 then 12 else l)
    L: (date, flags, width=3) -> date.getMilliseconds().to_s().rjust width, if '_' in flags then ' ' else '0'
    m: (date, flags, width=2) -> date.mon().to_s().rjust width, if '_' in flags then ' ' else '0'
    M: (date, flags, width=2) -> date.getMinutes().to_s().rjust width, if '_' in flags then ' ' else '0'
    n: (date) -> '\n'
    N: (date, flags, width=9) -> date.getMilliseconds().rjust width, if '_' in flags then ' ' else '0'
    o: (date) -> date.mon().ordinal()
    p: (date) -> if date.getHours() < 12 then 'am' else 'pm'
    P: (date) -> (@p date).upcase()
    Q: (date) -> date.getTime()
    r: (date) -> "#{@I date}:#{@M date}:#{@S date} #{@p date}"
    R: (date) -> "#{@H date}:#{@M date}"
    s: (date) -> date.getTime().to_s().substr(0, 10).to_i()
    S: (date, flags, width=2) -> date.getSeconds().to_s().rjust width, if '_' in flags then ' ' else '0'
    t: (date) -> '\t' 
    T: (date) -> "#{@R date}:#{@S date}"
    u: (date) -> date.cwday()
    U: (date) -> week = date.week Date.MONDAY; if week > 1 and date.yday() < 7 then 0 else week
    v: (date) -> "#{@e date}-#{@b date}-#{@Y date}"
    V: (date, flags, width=2) -> date.cweek().to_s().rjust width,  if '_' in flags then ' ' else '0'
    w: (date) -> date.day()
    W: (date) -> week = date.week Date.SUNDAY; if week > 1 and date.yday() < 7 then 0 else week
    x: (date) -> @D date
    X: (date) -> @T date
    y: (date, flags, width=2) -> (date.year() % 100).to_s().rjust width, if '_' in flags then ' ' else '0'
    Y: (date) -> date.year()
    z: (date, flags, width=0) -> 
      [_, op, zone] = date.to_s().match /^.*([+-])(\d{4}).+$/
      if ':' in flags then zone = zone.insert 2, ':'
      if '::' in flags then zone += ':00'
      if ':::' in flags then zone = zone.replace ':00', '' 
      if '_' in flags then (op + zone).rjust width, ' ' else op + zone.rjust width, '0' 
      
    Z: (date) -> date.to_s().replace /^.*\(([^)]+)\)$/, '$1'
    '+': (date) -> "#{@a date} #{@b date} #{@e date} #{@T date} #{@Z date} #{@Y date}"
    '%': (date) -> '%'
    
  SUNDAY:    0 
  MONDAY:    1
  TUESDAY:   2
  WEDNESDAY: 3 
  THURSDAY:  4 
  FRIDAY:    5 
  SATURDAY:  6
  
  commercial: (year, week, wday) ->
     (new Date year, 0, 1).change week: week, wday: wday
    
  ordinal: (year, day) ->
    new Date year, 0, day

  today: -> new Date
  
  is_leap: (year) ->
    (new Date year, 1, 30).mon() is 1

extend Date.prototype

  clone: ->
    new Date @valueOf()

  change: (options, value) ->
    
    if value? then key = options; options  = {}; options[key] = value;
    
    Object.map options, (value) ->
      (value or 0).to_i()
      
    @setFullYear options.year if 'year' of options
    @setMonth options.month-1 if 'month' of options
    @setDate options.day if 'day' of options
    @setHours options.hour if 'hour' of options
    @setMinutes options.min if 'min' of options
    @setMilliseconds options.usec if 'usec' of options;
    
    if 'week' of options
      # Get the day offset of week 1 of the year and add that to the weeks we want
      @setDate (7 - @start_of_year().cwday()) + (options.week or 0).to_i() * 7
    
    if 'cwday' of options
      options.wday = if options.cwday is 7 then 0 else options.cwday
    
    if 'wday' of options
      offset = @wday() - options.wday
      date.setDate if offset < 0 then -(7 + offset) else offset
    
    return @
  
  advance: (options, value) ->
    
    if value? then key = options; options  = {}; options[key] = value;
    
    Object.map options, (value) ->
      (value or 0).to_i()
      
    if 'weeks' of options
      options.days = (options.days or 0) + (options.weeks * 7)
    
    @change 
      year: @getFullYear() + options.years
      month: @getMonth() + options.months
      day: @getDate() + options.days
      hour: @getHours() + options.hours
      min: @getMinutes() + (options.minutes or options.mins)
      sec: @getSeconds() + (options.seconds or options.secs)
      usec: @getMilliseconds() + (options.milliseconds or options.usecs)
  
  prev: (options, value) ->
    
    if value? then key = options; options  = {}; options[key] = value;
    
    Object.map options, (value) ->
      (value or 0).to_i()
    
    if 'weeks' of options
      options.days = (options.days or 0) + (options.weeks * 7)
    
    @change 
      year: @getFullYear() - options.years
      month: @getMonth() - options.months
      day: @getDate() - options.days
      hour: @getHours() - options.hours
      minute: @getMinutes() - (options.minutes or options.mins)
      second: @getSeconds() - (options.seconds or options.secs)
      milliseconds: @getMilliseconds() - (options.milliseconds or options.usecs)
  
  ago: (seconds) ->
    @clone().prev seconds
  
  start_of_day: ->
    @clone().change hour: 0, min: 0, sec: 0, usec: 0
  
  start_of_month: ->
    @start_of_day().change day: 1
  
  start_of_quarter: ->
    @start_of_month().prev months: date.mon() % 4
  
  start_of_week: (start_date = Date.MONDAY) ->
    date = @start_of_day()
    date.prev date.wday() - start_date
  
  start_of_year: ->
    @start_of_day().change month: 1, day: 1
    
  end_of_month: ->
    @start_of_month().advance(months: 1).prev milliseconds: 1
  
  end_of_quarter: ->
    @start_of_quarter().advance(months: 4).prev milliseconds: 1
  
  end_of_week: (start_date = Date.MONDAY) ->
    @start_of_week(start_date).advance(days: 7).prev milliseconds: 1
    
  end_of_year: (start_date = Date.MONDAY) ->
    @start_of_year().advance(years: 1).prev milliseconds: 1
    
  is_future: ->
    @getTime() > Date.now()
  
  monday: ->
    @start_of_week()
    
  month: ->
    @getMonth() + 1
  
  months_ago: (months) ->
    @prev months: months
  
  months_since: (months) ->
    @advance months: months
  
  next_month: ->
    @months_since 1
    
  next_week: (day = Date.MONDAY) ->
    @end_of_week(day).change usec: 1000
  
  next_year: ->
    @years_since 1
  
  is_past: ->
    ! @is_future()
    
  prev_month: ->
    @months_ago 1
  
  prev_week: (day = Date.MONDAY) ->
    date = @start_of_week(day)
    if day > @wday() then date else date.prev weeks: 1
  
  prev_year: ->
    @years_ago 1
  
  since: (seconds) ->
    @clone().advance seconds: seconds
    
  sunday: ->
    @end_of_week()
  
  is_today: -> #TODO: Save from toString override using @format
    @toString().substr(0, 15) is (new Date).toString().substr 0, 15
    
  weeks_ago: (weeks) ->
    @clone().prev weeks: weeks
  
  years_ago: (years) ->
    @clone().prev years: years
    
  years_since: (years) ->
    @clone().advance years: years
    
  cwday: -> 
    day = @wday()
    if day is 0 then day = 7 else day
    
  cweek: ->
    @week Date.MONDAY
    
  cwyear: ->
    @wyear Date.MONDAY
    
  is_friday: ->
    @wday() is Date.FRIDAY
  
  is_leap: ->
    Date.is_leap @getFullYear()
    
  is_monday: ->
    @wday() is Date.MONDAY
  
  next: ->
    @next_day()
    
  next_day: (days = 1) ->
    @clone().advance days: days
    
  next_month: (months = 1) ->
    @clone().advance months: months
  
  next_year: (years = 1) ->
    @clone().advance years: years
  
  prev_day: (days = 1) ->
    @clone().prev days: days
  
  prev_month: (months = 1) ->
    @clone().prev months: months
  
  prev_year: (years = 1) ->
    @clone().prev years: years
  
  is_saturday: ->
    @wday() is Date.SATURDAY
  
  step: (limit, step = { days: 1 }, callback) ->  
    switch typeof step
      when 'number' then step = days:step
      when 'function' then callback = step; step = days: 1
    
    limit = new Date limit unless limit instanceof Date
    
    dates = []
    while ((next ||= @) < limit)
      callback?(next); dates.push new Date next
      next.advance step
      
    if typeof callback is 'function' then @ else dates
  
  strftime: (format = '%F') ->
    format.replace /%([-_0\^#:]*)?(\d+)?([EO])?([aAbBcCdDeFgGhHIjklLmMnNpPQrRsStTuUvVwWxXyYzZ])/gm, (flags, width, modifier, conversion) ->
      result = (Date.STRFTIME_FORMATS[conversion] @, flags, width, modifier)
      
      if width and result.length < width
        result = if typeof 'result' is 'number' and '-' not in flags
            result.to_s().rjust width, if '_' in flags then ' ' else '0'
          else result.rjust width, if '0' in flags then '0' else ' '
        
      for flag in flags
        switch flag
          when '^' then result.upcase()
          when '#' then result.swapcase()
      
      return result
        
  is_thursday: ->
    @wday() is Date.THURSDAY
  
  is_tuesday: ->
    @wday() is Date.TUESDAY
  
  wday: ->
    @getDay()
  
  is_wednesday: ->
    @wday() is Date.WEDNESDAY
  
  week: (start_day = Date.MONDAY) ->
    date = @clone()
    date.prev days: ((@wday() + (6 - start_date)) % 7) + 3
    offset = date.getTime()
    date.change month: 1, day: 1
    if date.wday() isnt 4 then date.change day: 1 + ((4 - date.wday()) + 7) % 7
    1 + Math.ceil (offset - date) / 604800000
  
  wyear: (start_date = Date.MONDAY) ->
    (@clone().prev day: ((@wday() + (6 - start_date)) % 7) + 3).year()
  
  yday: ->
    Math.ceil (@ - @start_of_year()) / 86400000
  
  time: ->
    hours: @getHours()
    mins: @getMinutes()
    minutes: @getMinutes()
    secs: @getSeconds()
    seconds: @getSeconds()
    usecs: @getMilliseconds()
    milliseconds: @getMilliseconds()
    toString: -> @usecs
    
  date: ->
    year: @year()
    month: @month()
    day: @day()
    wday: @wday()
    mday: @mday()
    cwyear: @cwyear()
    cweek: @cwweek()
    cwday: @cwday()
  
  to_i: ->
    @getTime()
  
  to_s: ->
    @toString()
    
  utc: ->
    new Date @toUTCString()
  
  utc_offset: ->
    @getTimezoneOffset() * 60

alias Date
  current: 'new'
  civil: 'new'

alias Date.prototype
  midnight: 'start_of_day'
  reverse: 'prev'
  before: 'prev'
  back: 'prev'
  beginning_of_day: 'start_of_day'
  beginning_of_month: 'start_of_month'
  beginning_of_quarter: 'start_of_quarter'
  beginning_of_week: 'start_of_week'
  beginning_of_year: 'start_of_year'
  mday: 'getDate'
  day: 'getDate'
  tomorrow: 'next'
  to_time: 'getTime'
  year: 'getFullYear'
  mon: 'month'
  set: 'change'