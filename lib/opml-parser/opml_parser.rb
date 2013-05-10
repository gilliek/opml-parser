require 'nokogiri'

# OpmlParser Module
#
# A very simple and easy to use module for importing and exporting OPML.
#
# Example:
# 	TODO
#
# == Credits
#
# Kevin Gillieron <kevin.gillieron@gw-computing.net>
#
module OpmlParser
	# Class representing an OPML outline element
	class Outline
		# OPML outline attributes (generally text, title, type, xmlUrl
		# and htmlUrl)
		attr_reader :attributes

		# Initializes an outline object
		#
		# Arguments:
		# 	attributes: (Hash) A Hash table that contains the attributes of the
		# 	outline.
		#
		def initialize(attributes=Hash.new)
			@attributes = attributes
		end
	end

	# Import an OPML String as an array of Outline object
	#
	# Arguments:
	# 	contents: (String) A String that contains the OMPL
	def import(contents)
		doc = Nokogiri.XML(contents)
		feeds = Array.new

		doc.xpath("//body//outline").inject(Array.new) do |feeds, outline|
			next if !outline.attributes.empty?
			feeds << Outline.new(xml_node_to_hash(outline.attributes))
		end
	end

	# Import an OPML String as an array of Outline object
	#
	# Arguments:
	# 	feeds: (Array of Outline) An array of Outline objects
	def export(feeds)
		builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
			xml.opml(version: "1.0") do
				xml.head { xml.title "RReader Exported Feeds" }
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
				attributes[k] = v.value
			end

			return attributes
		end
end
