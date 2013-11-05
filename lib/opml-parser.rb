require 'nokogiri'
require 'opml-parser/version'

# OpmlParser Module
#
# A very simple and easy to use module for importing and exporting OPML.
#
# == Credits
#
# Kevin Gillieron <kevin.gillieron@gw-computing.net>
#
module OpmlParser
	# OPML outline element
	class Outline
		# Outline attributes (generally text, title, type, xmlUrl and htmlUrl)
		attr_reader :attributes

		# Initializes an Outline object
		#
		# Arguments:
		# 	attributes: (Hash) A Hash table that contains the attributes of the
		# 	outline.
		#
		def initialize(attributes={})
			@attributes = attributes
		end
	end

	# Parse an OPML String into an array of Outline objects.
	#
	# Arguments:
	# 	contents: (String) A String that contains the OMPL
	def import(contents)
		doc = Nokogiri.XML(contents)

		doc.xpath("//body//outline").inject(Array.new) do |feeds, outline|
			next if outline.attributes.empty?
			feeds << Outline.new(xml_node_to_hash(outline.attributes))
		end
	end

	# Export an OPML String into an array of Outline objects.
	#
	# Arguments:
	# 	feeds: (Array of Outline) An array of Outline objects
	# 	title: (String) Title of the OPML document
	def export(feeds, title="No title")
		builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
			xml.opml(version: "1.0") do
				xml.head { xml.title title }
				xml.body { feeds.each { |outline| xml.outline(outline.attributes) }}
			end
		end
		builder.to_xml
	end

	private
		# Convert a Nokogiri XML Node to a Hash table
		def xml_node_to_hash(nokogiri_node)
			attributes = Hash.new

			nokogiri_node.each do |k,v|
				attributes[k.to_sym] = v.value
			end

			return attributes
		end
end
