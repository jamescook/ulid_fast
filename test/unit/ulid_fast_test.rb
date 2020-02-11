require_relative "../../lib/ulid_fast"
require "minitest/autorun"

describe 'ULID::Generator' do
  describe ".generate" do
    it 'returns sorted identifiers' do
      g = ULID::Generator.new
      ulid1 = g.generate
      ulid2 = g.generate
      ulid3 = g.generate

      assert_equal [ulid1, ulid2, ulid3], [ulid3, ulid1, ulid2].sort
    end

    it 'returns a string that is 26 characters long' do
      g = ULID::Generator.new
      ulid = g.generate

      assert_equal 26, ulid.bytesize
    end
  end
end
