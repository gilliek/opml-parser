require 'test/unit'
require 'opml-parser'

class OpmlParserTest < Test::Unit::TestCase
	def setup
		@opml = File.open('data/feeds.xml').readlines.join("")
		@outlines = OpmlParser::Outline({
			text:    "foo",
		  title:   "bar",
		  type:    "rss",
		  xmlUrl:  "http://www.gilliek.ch/feeds",
		  htmlUrl: "http://www.gilliek.ch" })
	end

	#import an OMPL String as an array of Outline object
	def test_import
	end

	# export an array of Outline object as an OPML String
	def test_export
	end
end
