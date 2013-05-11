require 'test/unit'
require 'opml-parser'

include OpmlParser

class OpmlParserTest < Test::Unit::TestCase
	def setup
		fin = File.open('test/data/feeds.xml')

		@opml = fin.readlines.join("")
		@outline = OpmlParser::Outline.new({
			text:    "foo",
		  title:   "bar",
		  type:    "rss",
		  xmlUrl:  "http://www.gilliek.ch/feeds",
		  htmlUrl: "http://www.gilliek.ch" })

		fin.close
	end

	#import an OMPL String as an array of Outline object
	def test_import
		outlines = OpmlParser::import(@opml)

		assert_equal(outlines.length, 1)
		assert_equal(outlines[0].attributes[:text]   , @outline.attributes[:text])
		assert_equal(outlines[0].attributes[:title]  , @outline.attributes[:title])
		assert_equal(outlines[0].attributes[:type]   , @outline.attributes[:type])
		assert_equal(outlines[0].attributes[:xmlUrl] , @outline.attributes[:xmlUrl])
		assert_equal(outlines[0].attributes[:htmlUrl], @outline.attributes[:htmlUrl])
	end

	# export an array of Outline object as an OPML String
	def test_export
		ary = Array.new
		ary << @outline
		opml = OpmlParser::export(ary)
		outlines = OpmlParser::import(opml)

		assert_equal(outlines.length, 1)
		assert_equal(outlines[0].attributes[:text]   , @outline.attributes[:text])
		assert_equal(outlines[0].attributes[:title]  , @outline.attributes[:title])
		assert_equal(outlines[0].attributes[:type]   , @outline.attributes[:type])
		assert_equal(outlines[0].attributes[:xmlUrl] , @outline.attributes[:xmlUrl])
		assert_equal(outlines[0].attributes[:htmlUrl], @outline.attributes[:htmlUrl])
	end
end
