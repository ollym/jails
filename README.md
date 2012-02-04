#Welcome to Jails
Jails brings the essential parts of the Ruby Standard Library (Std-lib) and core extensions from Ruby on Rails to give you the missing library for CoffeeScript.

## Coding Standards

  * Underscores are used in place of camelCase
  * Callbacks/Blocks are always given as the last parameter
  * Object.prototype is left untouched
  * Date.prototype has been partially extended to be localized
  * Ruby's self modification identifier (!) is replaced with $ in Jails

## Examples
Below are some examples illustrating the uses of Jails and it's similarities to Ruby (and Rails).

### Date Handling

#### Number Helpers
```coffeescript
1.month.from_now() // returns a new Date 1 month from now
2.weeks.ago() // returns a new Date 2 weeks ago from now
```

#### Date Manipulators
```coffeescript
1.month.from_now().start_of_week() // returns a new Date 1 month from now on the monday at 00:00 of that week
```

#### String Formats
```coffeescript
Date.new(2011, 1, 1, 11, 30, 15).format('%A %-d%o of %B %Y %T %p')
  // Sunday 1st of January 2012 11:30:15 AM
```
> Note: `Date.new` uses months starting from 1 rather than 0, all other methods also assume this other than `date.getMonth()` and `new Date`