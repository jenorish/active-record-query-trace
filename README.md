Logs the source of execution of all queries to the Rails log. Helpful to track down where queries are being executed in your application, for performance optimizations most likely.

Install
-------

`gem install active_record_query_trace`

Usage
-----

Enable it in an initializer:

```ruby
ActiveRecordQueryTrace.enabled = true

print logs in seperate log file
ActiveRecordQueryTrace.new_log = true

you want to create log by day wise means you have to enable 
ActiveRecordQueryTrace.daywise = true
```

Options
_______

There are three levels of debug. 

1. app - includes only files in your app/ directory.
2. full - includes files in your app as well as rails.
3. rails - alternate ouput of full backtrace, useful for debugging gems.

```ruby
ActiveRecordQueryTrace.level = :app # default

ActiveRecordQueryTrace.new_log = false # defalut

ActiveRecordQueryTrace.daywise = false # defalut
```

Additionally, if you are working with a large app, you may wish to limit the number of lines displayed for each query.

```ruby
ActiveRecordQueryTrace.lines = 10 # Default is 5. Setting to 0 includes entire trace.
```

Output
------

When enabled every query source will be logged like:

```
Time: Wed Jan 07 2015 20:12:45 +05:30
Called from: app/views/sites/site.html.erb:1:in '
 app/controllers/application_controller.rb:37:in `load'
Query:             SELECT "intuit_accounts".* FROM "intuit_accounts" WHERE "intuit_accounts"."user_id" = 20 LIMIT 1

```
forked from ruckus/active-record-query-trace

Thanks to Cody Caughlan

Requirements
------------
Rails 3+

Copyright (c) 2011 Cody Caughlan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
