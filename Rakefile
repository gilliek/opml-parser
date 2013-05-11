require "bundler/gem_tasks"

require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new(:test) do |test|
	test.libs << 'lib' << 'test'
	test.pattern = 'test/**/*_test.rb'
	test.verbose = true
end

Rake::RDocTask.new(:doc) do |rd|
	rd.main = "README.md"
	rd.rdoc_files.include("README.md", "lib/**/*.rb")
end
