# Array
Below are all the methods included, excluded and provided as extra from the Ruby (on Rails) library.

## Included
  * assoc
  * at: (index)
  * clear
  * combination: (num)
  * compact
  * compact$
  * count: (obj)
  * cycle: (num, callback)
  * delete: (obj, callback)
  * delete_at: (index)
  * delete_if: (callback)
  * drop: (num)
  * drop_while: (callback)
  * each: (callback)
  * each_index: (callback)
  * empty:
  * eql: (other)
  * fetch: (index, value)
  * fill: (obj, start = 0, length = @length)
  * first: (n = 1)
  * flatten: (level)
  * flatten$: (level)
  * grep: (regex)
  * grep$: (regex)
  * index: (obj)
  * include: (obj)
  * replace: (values)
  * insert: (index, obj...)
  * last: (n = 1)
  * reject: (callback)
  * rassoc: (obj)
  * reverse$:
  * reverse_each: (callback)
  * pop: (n = 1)
  * vrindex: (obj)
  * rotate: (cnt = 1)
  * rotate$: (cnt = 1)
  * sample: (n=1)
  * shift: (n = 1)
  * shuffle:
  * shuffle$:
  * size:
  * slice$: (start, end)
  * sort$: (sort)
  * sort_by: (prop, sort = (a,b) -> if a > b then 1 else if a < b then -1 else 0)
  * take_while: (callback)
  * to_ary
  * to_s
  * to_sentense: (seperator)
  * transpose:
  * uniq:
  * uniq$:
  * values_at: (selectors...)
  * zip: (arrays...)

## Extras
  * concat$: (values...)
    Same as concat except it's applied to the current array
    
    ```coffeescript
    [1,2,3].concat$ [4,5], 6 # [1,2,3,4,5,6]
    ```
    
  * swap: (index1, index2)
    Swaps 2 values within the current array at the given indexes
    
    ```coffeescript
    [1,2,3].swap 0,2 # [3,2,1]
    ```
  
  * remove: (values...)
    Removes the set of values from the current array
    
    ```coffeescript
    [1,2,3].remove 1,2 # [3]
    ```

  * clone
    Clones the current array
    
    ```coffeescript
    a = [1,2,3]; a.clone() is a # false
    ```
    
  * intersect: (values...)
    Calculates the intersection for a set of values or arrays
    
    ```coffeescript
    [1,2,3].interesct [1,4], 2 # [1,2]
    ```
  
  * diff: (values...)
    Calculates the difference between a set of values or arrays
    
    ```coffeescript
    [1,2,3].diff [1,4], 2 # [3]
    ```
  
  * union: (values...)
    Finds the union between a set of values or arrays. (same as: array.concat(values...).uniq())
    
    ```coffeescript
    [1,2,3].union [1,4], 2 # [1,2,3,4]
    ```
    
  * chunk: (size)
    Splits the array into chunks of a certain size and returns the new array
    
    ```coffeescript
    [1,2,3,4,5,6].chunk 2 # [[1,2], [3,4], [5,6]]
    ```
  
  * chunk: (size)
    Splits the current array into chunks of a certain size

    ```coffeescript
    [1,2,3,4,5,6].chunk 2 # [[1,2], [3,4], [5,6]]
    ```
    
  * invoke: (callback, args...)
    Invokes a function on all items within the array and returns a new array with the results from that function call
    
    ```coffeescript
    [1.2, 2.5, 3.8, 4.1].invoke 'round' # [1,3,4,4]
    ```

  * invoke$: (callback, args...)
    Same as invoke except the returned values replace the originals and the current array is returned

    ```coffeescript
    [1.2, 2.5, 3.8, 4.1].invoke 'round' # [1,3,4,4]
    ```
    
  * pluck: (properties...)
    Returns an array containing a filtered object
    
    ```coffeescript
    a = name: 'Ann', age: 36, pass: 's8J2ld0a'
    b = name: 'Bob', age: 21, pass: '0aJdlfsa'
    c = name: 'Charlie', age: 31, pass: 'f8fadasa'
    
    [a,b,c].pluck 'name', 'age'
    ```
        
## Aliases
  * collect: 'map'
  * collect$: 'map$'
  * each: 'forEach'
  * find_index: 'index'
  * keep_if: 'filter$'
  * reject$: 'delete_if'
  * select: 'map'
  * select$: 'map$'
  * take: 'first'
  * ary: 'slice'
  * ary$: 'slice$'
  * contains: 'include'

## Excluded
 * frozen
 * hash
 * product
 * repeated_combination
 * repeated_permutation