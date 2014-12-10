ActiveRecord Without Rails
==========================

Just a simple example of using ActiveRecord migrations without Rails

tasks you can do:  rake --tasks
(including)
* `rake db:create`
* `rake db:migrate`
* `rake db:drop`

Or, you can run the thing to show that it'll connect 
( after editing config.database.yml )

```
ruby no-rails
```

Output:
> Count of Pages: 0

Lastly, you can IRB it to do stuff:

$ irb

```
>> require "./no-rails"
=> true
>> Page.new
=> #<Page id: nil, content: nil, published: false>
>> Page.create content: "the-content"
=> #<Page id: 1, content: "the-content", published: false>
```

Copyright
---------
None. Really.
