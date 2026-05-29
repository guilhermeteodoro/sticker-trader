# frozen_string_literal: true

# Parses the app's dump format: SA26|1|<owned_ranges>|<duplicates>
# Returns { owned: Set<position>, duplicates: Hash<position, copies> }
class DumpParser
  ParseError = Class.new(StandardError)

  def initialize(raw)
    @raw = raw.strip
  end

  def call
    parts = @raw.split("|")
    raise ParseError, "Invalid header: expected SA26, got #{parts[0]}" unless parts[0] == "SA26"

    owned = expand_ranges(parts[2])
    duplicates = parse_duplicates(parts[3])

    { owned: owned, duplicates: duplicates }
  end

  private

  def expand_ranges(ranges_str)
    result = Set.new
    return result if ranges_str.nil? || ranges_str.strip.empty?

    ranges_str.split(",").each do |part|
      part = part.strip
      if part.include?("-")
        s, e = part.split("-", 2).map(&:to_i)
        result.merge(s..e)
      else
        result.add(part.to_i)
      end
    end
    result
  end

  def parse_duplicates(dupes_str)
    result = {}
    return result if dupes_str.nil? || dupes_str.strip.empty?

    dupes_str.split(",").each do |part|
      sticker, count = part.strip.split(":")
      result[sticker.to_i] = count.to_i
    end
    result
  end
end
