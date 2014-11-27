OPML-Parser
===========

[![Build Status](https://travis-ci.org/gilliek/opml-parser.png?branch=master)](https://travis-ci.org/gilliek/opml-parser) [![Dependencies Status](https://gemnasium.com/gilliek/opml-parser.png)](https://gemnasium.com/gilliek/opml-parser) [![Gem Version](https://badge.fury.io/rb/opml-parser.svg)](http://badge.fury.io/rb/opml-parser) [![opml-parser API Documentation](https://www.omniref.com/ruby/gems/opml-parser.png)](https://www.omniref.com/ruby/gems/opml-parser)

opml-parser is a simple Ruby gem that provides a module for parsing OPML.

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

See http://doc.gw-computing.net/opml-parser
