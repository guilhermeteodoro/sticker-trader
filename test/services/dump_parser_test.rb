# frozen_string_literal: true

require "test_helper"

class DumpParserTest < ActiveSupport::TestCase
  test "parses owned stickers from ranges" do
    result = DumpParser.new("SA26|1|1-3,5,7-9|").call

    assert_equal Set[1, 2, 3, 5, 7, 8, 9], result[:owned]
  end

  test "parses duplicates with counts" do
    result = DumpParser.new("SA26|1|1-3|1:2,3:1").call

    assert_equal({ 1 => 2, 3 => 1 }, result[:duplicates])
  end

  test "handles empty duplicates section" do
    result = DumpParser.new("SA26|1|1-5|").call

    assert_equal({}, result[:duplicates])
  end

  test "handles no duplicates field at all" do
    result = DumpParser.new("SA26|1|1-5").call

    assert_equal({}, result[:duplicates])
  end

  test "raises on invalid header" do
    assert_raises(DumpParser::ParseError) do
      DumpParser.new("INVALID|1|1-5|").call
    end
  end

  test "parses real dump correctly" do
    result = DumpParser.new(sample_dump).call

    assert_equal 591, result[:owned].size
    assert_equal 202, result[:duplicates].size
    assert_equal 270, result[:duplicates].values.sum
  end

  test "owned and duplicates are consistent in real dump" do
    result = DumpParser.new(sample_dump).call

    # All duplicate stickers should be in the owned set
    result[:duplicates].each_key do |position|
      assert_includes result[:owned], position, "Duplicate at position #{position} not in owned set"
    end
  end
end
