module OpmlParser
	require 'nokogiri'

	class Outline
		attr_reader :attributes

		def initialize(nokogiri_attributes)
			@attributes = Hash.new

			nokogiri_attributes.each do |k,v|
				@attributes[k] = v.value
			end
		end
	end

	def import(contents)
		doc = Nokogiri.XML(contents)
		feeds = Array.new

		doc.xpath("//body//outline").inject(Array.new) do |feeds, outline|
			feeds << Outline.new(outline.attributes) if !outline.attributes.empty?
		end
	end

	def export(feeds)
		builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
			xml.opml(version: "1.0") do
				xml.head { xml.title "RReader Exported Feeds" }
				xml.body { feeds.each { |outline| xml.outline(outline.attributes) }}
			end
		end
		builder.to_xml
	end
end
