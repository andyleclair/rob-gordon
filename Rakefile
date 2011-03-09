require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "rob-gordon"
  gem.homepage = "http://github.com/andyleclair/rob-gordon"
  gem.license = "MIT"
  gem.summary = %Q{A music organizer, for the self confessed obsessive}
  gem.description = %{
	"What came first, the music or the misery? People worry about kids playing with guns, or watching violent videos, that some sort of culture of violence will take them over. 

	Nobody worries about kids listening to thousands, literally thousands of songs about heartbreak, rejection, pain, misery and loss. 

	Did I listen to pop music because I was miserable? Or was I miserable because I listened to pop music?"

	usage:
	rob %folder %library
}
  gem.email = "andyleclair@gmail.com"
  gem.authors = ["andyleclair"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rob-gordon #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
