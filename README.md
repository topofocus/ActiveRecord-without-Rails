ActiveRecord Without Rails
==========================

A simple example of using ActiveRecord  without Rails
using ActiveRecord 4.1.8 and MySQL
 
includes RSpec-test-suite with Girl-Factory and Guard

Setup with »bundle install , bundle update» and configure 
config/database.yml as in Rails.


tasks you can do:  rake --tasks
(including)
* `rake db:create`
* `rake db:migrate`
* `rake db:drop`

You can run the thing to show that it'll connect 

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
MIT
