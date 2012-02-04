#Welcome to Jails
Jails brings the essential parts of the Ruby Standard Library (Std-lib) and core extensions from Ruby on Rails to give you the missing library for CoffeeScript.

## Things To Know

  * Underscores are used in place of camelCase unless already defined by javascript (eg. `(new Date).getMonth()`)
  * Callbacks/Blocks are always given as the last parameter unless otherwise defined in javascript (eg. `[].reduce(callback, initial)`)
  * Object.prototype is left untouched, to define object methods on your object use `Object.hash()`` or `Object.hash$()`
  * Date.prototype has been partially extended to be localized
  * Ruby's self modification identifier (!) is replaced with $ in Jails but only used if another method by the same name does not self-modify the object.

## Examples
Below are some examples illustrating the uses of Jails and it's similarities to Ruby (and Rails).

### Date Handling

#### Number Helpers
```coffeescript
1.month.from_now() # returns a new Date 1 month from now
2.weeks.ago() # returns a new Date 2 weeks ago from now
```

#### Date Manipulators
```coffeescript
1.month.from_now().start_of_week() # returns a new Date 1 month from now on the monday at 00:00 of that week
```

#### String Formats
```coffeescript
Date.new(2011, 1, 1, 11, 30, 15).format('%A %-d%o of %B %Y %T %p')
  # Sunday 1st of January 2012 11:30:15 AM
```
> Note: `Date.new` uses months starting from 1 rather than 0, all other methods also assume this other than `date.getMonth()` and `new Date`

## Contributing

Fork -> Pull Request -> Discuss

Don't forget tests.