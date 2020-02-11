require 'rake/testtask'
require 'rake/extensiontask'

spec = Gem::Specification.load('ulid_fast.gemspec')
Rake::ExtensionTask.new('ulid_fast', spec)

Rake::TestTask.new(test: [:clean, :clobber, :compile]) do |t|
  t.description = "Run unit tests"
  t.libs << "test"
  t.test_files = FileList['test/unit/*.rb']
  t.verbose = true
end

task :default => ["test"]

