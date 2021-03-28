# Ruby Repldb
The ease of using repldb now meets the ease of developing in Ruby!
You can learn more about repldb [here](https://docs.replit.com/misc/database)

# Usage
```rb
require "repldb"
db = Client.new

db.set("key", "value")
puts db.get("key") # => value
db.del_all()
```

# Docs
## `class Client`
### `Client#initialize(url)`
Change `url` to point to a different path.

### `Client#set(key, value)`
Sets `key` to `val`.

### `Client#get(key, default)`
Gets `key`.

If it doesn't exist, `default` will be used.

### `Client#del(key)`
Deletes `key`.

### `Client#keys(prefix)`
Get all the keys as an array.

`prefix` can be used to get all keys with a prefix.

### `Client#del_all()`
Deletes all keys, ultimately emptying the database.

### `Client#set_hash(hash)`
This will append `hash`.

**This will NOT replace existing keys!**

### `Client#get_hash()`
Gets all the keys as a hash.

### `Client#exists?(key)`
Check if `key` exists.