# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'opml-parser/version'

Gem::Specification.new do |spec|
  spec.name          = "opml-parser"
  spec.version       = OpmlParser::VERSION::STRING
  spec.authors       = ["Kevin Gillieron"]
  spec.email         = ["kevin.gillieron@gw-computing.net"]
  spec.description   = %q{A simple OPML parser}
  spec.summary       = %q{A simple OPML parser}
  spec.homepage      = "http://projects.gw-computing.net/projects/opml-parser"
  spec.license       = "3-clause BSD"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
