require_relative "./lib/ulid_fast/version"

Gem::Specification.new do |s|
  s.name    = "ulid_fast"
  s.version = ULID::VERSION
  s.summary = "ULID Ruby C Extension"
  s.author  = "James Cook"
  s.platform = Gem::Platform::RUBY
  s.homepage = "https://github.com/jamescook/ulid_fast"

  s.files = Dir.glob("ext/**/*.{c,h,rb}") +
            Dir.glob("lib/**/*.{rb}")

  s.extensions << "ext/ulid_fast/extconf.rb"
  s.licenses << "MIT"

  s.add_development_dependency "rake-compiler", "~> 1"
  s.add_development_dependency "minitest", "~> 5"
  s.required_ruby_version = '> 2.1'
end
