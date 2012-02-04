# Object.Hash
The Object.Hash class was introduced to avoid altering Object.prototype. Choose to use it by simply extending your existing classes like:

```
class MyObject extends Object.Hash
  foo: function() { } ...
```

Or wrap existing objects by passing them as a parameter to Object.Hash like so: `new Object.Hash { foo: 'bar' }` or `Object.Hash.new object`. Note that only enumerable properties belonging to the object will be copied across and your prototype chain will be replaced.

## Included
  * assoc: (key)
  * clear
  * delete: (key)
  * delete_if: (callback)
  * each: (callback)
  * each_key: (callback)
  * each_value: (callback)
  * empty
  * eql: (other)
  * fetch: (key, default)
  * flatten: (level = 1)
  * has_key: (key)
  * has_value: (value)
  * to_a
  * to_hash
  * inspect
  * invert
  * keep_if
  * key: (value)
  * keys
  * size
  * merge: (other, callback)
  * merge$: (other, callback)
  * rassoc: (key)
  * reject: (callback)
  * reject$: (callback)
  * replace: (other)
  * select: (callback)
  * select$: (callback)
  * shift
  * values
  * values_at

## Extras
 * clone
   Clones the Hash into a new Hash object.
   
 * every: (callback |key,value|)
   Ensures that the callback returns true for each of the items within the hash
   
 * names
   Returns all the property names belonging to the object (enumerable or not). keys() on the other hand only returns the enumerable ones.
   
 * has_name: (name)
   Is the same as @names().contains(name)
   
 * to_json: (replacer, space)
   Turns the hash into JSON using the replacer and space parameters passed to JSON.stringify

## Excluded
 * compare_by_identity
 * default
 * default_proc
 * hash
 * rehash