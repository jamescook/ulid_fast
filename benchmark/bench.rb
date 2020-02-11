#!/usr/bin/env ruby

# To run this benchmark:
# bundle exec ruby benchmark/bench.rb ulid_fast
# ... (runs 1st segment (ulid_fast) ) ...
#
# Now uncomment the 'gem "ulid"' line in the Gemfile and bundle.
# Then, `bundle exec ruby benchmark/bench.rb`
# ... (runs 2nd segment (ulid) )

require 'benchmark/ips'
require 'benchmark/memory'

if ARGV[0] == "ulid_fast"
  require_relative '../lib/ulid_fast'
  g = ULID::Generator.new
else
  require 'ulid' # Install separately
end

puts "Benchmarking memory ..."
Benchmark.memory do |x|
  x.report("ULID::Generator#generate") { g.generate }
  x.hold!(".bench-mem")
  x.report("ULID.generate") { ULID.generate }
  x.compare!
end

puts
puts

puts "Benchmarking ips ..."
Benchmark.ips do |x|
  x.time = 10
  x.report("ULID::Generator#generate") { g.generate }
  x.hold!(".bench-speed")
  x.report("ULID.generate") { ULID.generate }
  x.compare!
end

