# frozen_string_literal: true

# Seed countries and the sticker catalog — 994 stickers total.

COUNTRIES_DATA = [
  { code: "FWC", emoji: "🏆", size: 20, color: "#DAA520", group_name: "FIFA World Cup" },
  { code: "CC",  emoji: "🥤", size: 14, color: "#E61E2B", group_name: "Coca-Cola" },
  { code: "MEX", emoji: "🇲🇽", size: 20, color: "#006847", group_name: "A" },
  { code: "RSA", emoji: "🇿🇦", size: 20, color: "#007A4D", group_name: "A" },
  { code: "KOR", emoji: "🇰🇷", size: 20, color: "#CD2E3A", group_name: "A" },
  { code: "CZE", emoji: "🇨🇿", size: 20, color: "#11457E", group_name: "A" },
  { code: "CAN", emoji: "🇨🇦", size: 20, color: "#FF0000", group_name: "B" },
  { code: "BIH", emoji: "🇧🇦", size: 20, color: "#002395", group_name: "B" },
  { code: "QAT", emoji: "🇶🇦", size: 20, color: "#8A1538", group_name: "B" },
  { code: "SUI", emoji: "🇨🇭", size: 20, color: "#FF0000", group_name: "B" },
  { code: "BRA", emoji: "🇧🇷", size: 20, color: "#009739", group_name: "C" },
  { code: "MAR", emoji: "🇲🇦", size: 20, color: "#C1272D", group_name: "C" },
  { code: "HAI", emoji: "🇭🇹", size: 20, color: "#00209F", group_name: "C" },
  { code: "SCO", emoji: "🏴󠁧󠁢󠁳󠁣󠁴󠁿", size: 20, color: "#005EB8", group_name: "C" },
  { code: "USA", emoji: "🇺🇸", size: 20, color: "#3C3B6E", group_name: "D" },
  { code: "PAR", emoji: "🇵🇾", size: 20, color: "#D52B1E", group_name: "D" },
  { code: "AUS", emoji: "🇦🇺", size: 20, color: "#00008B", group_name: "D" },
  { code: "TUR", emoji: "🇹🇷", size: 20, color: "#E30A17", group_name: "D" },
  { code: "GER", emoji: "🇩🇪", size: 20, color: "#000000", group_name: "E" },
  { code: "CUW", emoji: "🇨🇼", size: 20, color: "#002B7F", group_name: "E" },
  { code: "CIV", emoji: "🇨🇮", size: 20, color: "#F77F00", group_name: "E" },
  { code: "ECU", emoji: "🇪🇨", size: 20, color: "#FFD100", group_name: "E" },
  { code: "NED", emoji: "🇳🇱", size: 20, color: "#FF4F00", group_name: "F" },
  { code: "JPN", emoji: "🇯🇵", size: 20, color: "#BC002D", group_name: "F" },
  { code: "SWE", emoji: "🇸🇪", size: 20, color: "#006AA7", group_name: "F" },
  { code: "TUN", emoji: "🇹🇳", size: 20, color: "#E70013", group_name: "F" },
  { code: "BEL", emoji: "🇧🇪", size: 20, color: "#000000", group_name: "G" },
  { code: "EGY", emoji: "🇪🇬", size: 20, color: "#CE1126", group_name: "G" },
  { code: "IRN", emoji: "🇮🇷", size: 20, color: "#239F40", group_name: "G" },
  { code: "NZL", emoji: "🇳🇿", size: 20, color: "#00247D", group_name: "G" },
  { code: "ESP", emoji: "🇪🇸", size: 20, color: "#AA151B", group_name: "H" },
  { code: "CPV", emoji: "🇨🇻", size: 20, color: "#003893", group_name: "H" },
  { code: "KSA", emoji: "🇸🇦", size: 20, color: "#006C35", group_name: "H" },
  { code: "URU", emoji: "🇺🇾", size: 20, color: "#5CBEF0", group_name: "H" },
  { code: "FRA", emoji: "🇫🇷", size: 20, color: "#002395", group_name: "I" },
  { code: "SEN", emoji: "🇸🇳", size: 20, color: "#00853F", group_name: "I" },
  { code: "IRQ", emoji: "🇮🇶", size: 20, color: "#007A3D", group_name: "I" },
  { code: "NOR", emoji: "🇳🇴", size: 20, color: "#EF2B2D", group_name: "I" },
  { code: "ARG", emoji: "🇦🇷", size: 20, color: "#75AADB", group_name: "J" },
  { code: "ALG", emoji: "🇩🇿", size: 20, color: "#006233", group_name: "J" },
  { code: "AUT", emoji: "🇦🇹", size: 20, color: "#ED2939", group_name: "J" },
  { code: "JOR", emoji: "🇯🇴", size: 20, color: "#007A3D", group_name: "J" },
  { code: "POR", emoji: "🇵🇹", size: 20, color: "#006600", group_name: "K" },
  { code: "COD", emoji: "🇨🇩", size: 20, color: "#007FFF", group_name: "K" },
  { code: "UZB", emoji: "🇺🇿", size: 20, color: "#1EB53A", group_name: "K" },
  { code: "COL", emoji: "🇨🇴", size: 20, color: "#FCD116", group_name: "K" },
  { code: "ENG", emoji: "🏴󠁧󠁢󠁥󠁮󠁧󠁿", size: 20, color: "#CF081F", group_name: "L" },
  { code: "CRO", emoji: "🇭🇷", size: 20, color: "#FF0000", group_name: "L" },
  { code: "GHA", emoji: "🇬🇭", size: 20, color: "#006B3F", group_name: "L" },
  { code: "PAN", emoji: "🇵🇦", size: 20, color: "#005EB8", group_name: "L" }
].freeze

# Parse sticker names from docs/groups/ markdown files
def load_sticker_names
  names = {}
  Dir.glob(Rails.root.join("docs/groups/*.md")).each do |file|
    File.readlines(file).each do |line|
      next unless line.match?(/^- [A-Z]{2,3} \d+/)
      # Format: "- MEX 1 - Team Logo (Foil)"
      if line =~ /^- ([A-Z]{2,3}) (\d+) - (.+)$/
        code, number, name = $1, $2, $3.strip
        names[[ code, number ]] = name
      end
    end
  end
  names
end

def category_for(code, number)
  return :shiny if code == "FWC"
  return :coke if code == "CC"
  return :shiny if number == "1"
  :normal
end

puts "Seeding countries and stickers..."

# Create/update countries
countries = {}
COUNTRIES_DATA.each do |data|
  country = Country.find_or_initialize_by(code: data[:code])
  country.emoji = data[:emoji]
  country.color = data[:color]
  country.group_name = data[:group_name]
  country.save! if country.new_record? || country.changed?
  countries[data[:code]] = country
end

# Load sticker names from markdown files
sticker_names = load_sticker_names

# Create stickers
stickers = []
position = 1

COUNTRIES_DATA.each do |data|
  country = countries[data[:code]]
  numbers = if data[:code] == "FWC"
    [ "00" ] + (1..19).map(&:to_s)
  else
    (1..data[:size]).map(&:to_s)
  end

  numbers.each do |number|
    name = sticker_names[[ data[:code], number ]]
    stickers << {
      country_id: country.id,
      number: number,
      name: name,
      category: category_for(data[:code], number),
      position: position
    }
    position += 1
  end
end

Sticker.upsert_all(stickers, unique_by: :position)

puts "Seeded #{Country.count} countries, #{Sticker.count} stickers (shiny: #{Sticker.shiny.count}, coke: #{Sticker.coke.count}, normal: #{Sticker.normal.count})"
named_count = Sticker.where.not(name: nil).count
puts "  #{named_count} stickers with names"
