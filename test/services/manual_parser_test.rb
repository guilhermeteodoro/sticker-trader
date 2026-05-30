# frozen_string_literal: true

require "test_helper"

class ManualParserTest < ActiveSupport::TestCase
  test "parses missing stickers and infers owned" do
    missing_text = "FWC: 00, 3, 4"
    duplicates_text = ""

    result = ManualParser.new(missing_text: missing_text, duplicates_text: duplicates_text).call

    # FWC has 20 stickers, 3 are missing, so 991 owned (994 - 3)
    assert_equal 991, result[:owned].size
    refute_includes result[:owned], 1  # FWC 00 is position 1
    refute_includes result[:owned], 4  # FWC 3 is position 4
    refute_includes result[:owned], 5  # FWC 4 is position 5
  end

  test "parses duplicates with counts" do
    missing_text = ""
    duplicates_text = "FWC: 9(1x), 10(1x), 12(1x)\nMEX: 4(3x)"

    result = ManualParser.new(missing_text: missing_text, duplicates_text: duplicates_text).call

    assert_equal 4, result[:duplicates].size
    # FWC 9 is position 10
    assert_equal 1, result[:duplicates][10]
    # MEX 4 is position 24 (FWC=20, CC=14, MEX starts at 35, MEX 4 = 38)
    assert_equal 3, result[:duplicates][38]
  end

  test "ignores app share text preamble" do
    missing_text = <<~TEXT
      Hey, these are my missing stickers:

      Download the app: https://moovtech.app/stickers2026/ and let's trade!

      FWC: 00, 3
    TEXT
    duplicates_text = <<~TEXT
      Hey, these are my duplicate stickers:

      Download the app: https://moovtech.app/stickers2026/ and let's trade!

      FWC: 9(1x)
    TEXT

    result = ManualParser.new(missing_text: missing_text, duplicates_text: duplicates_text).call

    assert_equal 992, result[:owned].size
    assert_equal 1, result[:duplicates].size
  end

  test "raises on unknown sticker" do
    missing_text = "XXX: 1, 2, 3"
    duplicates_text = ""

    assert_raises(ManualParser::ParseError) do
      ManualParser.new(missing_text: missing_text, duplicates_text: duplicates_text).call
    end
  end
end
