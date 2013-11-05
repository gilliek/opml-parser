OPML-Parser
===========

opml-parser is a simple gem that provides OPML parsing and export to OPML.

Installation
============

```gem install opml-parser```

Usage
=====

Import
------

`subscriptions.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.0">
    <head>
        <title>Foobar</title>
    </head>
    <body>
        <outline text="foo" title="bar" type="rss" xmlUrl="http://www.gilliek.ch/feeds" htmlUrl="http://www.gilliek.ch"/>
    </body>
</opml>
```

```ruby
require 'opml-parser'
include OpmlParser

file = File.open("subscriptions.xml")
content = file.readlines.join("")

outlines = OpmlParser.import(content)

puts outlines[0].attributes

file.close
```

Output:

```
{:text=>"foo", :title=>"bar", :type=>"rss", :xmlUrl=>"http://www.gilliek.ch/feeds", :htmlUrl=>"http://www.gilliek.ch"}
```

Export
------

```ruby
require 'opml-parser'
include OpmlParser

feed = {:text=>"foo", :title=>"bar", :type=>"rss",
        :xmlUrl=>"http://www.gilliek.ch/feeds",
        :htmlUrl=>"http://www.gilliek.ch"}

outline = OpmlParser::Outline.new(feed)

opml = OpmlParser.export([outline], "Foobar")

output = File.new("output.xml", "w")
output.puts(opml)
output.close
```
`output.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.0">
    <head>
        <title>Foobar</title>
    </head>
    <body>
        <outline text="foo" title="bar" type="rss" xmlUrl="http://www.gilliek.ch/feeds" htmlUrl="http://www.gilliek.ch"/>
    </body>
</opml>
```

Documentation
=============

See http://www.gilliek.ch/doc/opml-parser/OpmlParser.html
