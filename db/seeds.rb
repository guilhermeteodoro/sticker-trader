# frozen_string_literal: true

# Seed the sticker catalog — 994 stickers total.
# FWC: 20 stickers (00, 1–19) — all shiny
# CC: 14 stickers (1–14) — all coke
# 48 teams: 20 stickers each (1–20) — sticker 1 is shiny, 2–20 are normal

TEAMS = [
  ["FWC", 20], ["CC", 14],
  ["MEX", 20], ["RSA", 20], ["KOR", 20], ["CZE", 20], ["CAN", 20],
  ["BIH", 20], ["QAT", 20], ["SUI", 20], ["BRA", 20], ["MAR", 20],
  ["HAI", 20], ["SCO", 20], ["USA", 20], ["PAR", 20], ["AUS", 20],
  ["TUR", 20], ["GER", 20], ["CUW", 20], ["CIV", 20], ["ECU", 20],
  ["NED", 20], ["JPN", 20], ["SWE", 20], ["TUN", 20], ["BEL", 20],
  ["EGY", 20], ["IRN", 20], ["NZL", 20], ["ESP", 20], ["CPV", 20],
  ["KSA", 20], ["URU", 20], ["FRA", 20], ["SEN", 20], ["IRQ", 20],
  ["NOR", 20], ["ARG", 20], ["ALG", 20], ["AUT", 20], ["JOR", 20],
  ["POR", 20], ["COD", 20], ["UZB", 20], ["COL", 20], ["ENG", 20],
  ["CRO", 20], ["GHA", 20], ["PAN", 20],
].freeze

def category_for(team, number)
  return :shiny if team == "FWC"
  return :coke if team == "CC"
  return :shiny if number == "1"
  :normal
end

puts "Seeding stickers..."

stickers = []
position = 1

TEAMS.each do |team, size|
  numbers = if team == "FWC"
    ["00"] + (1..19).map(&:to_s)
  else
    (1..size).map(&:to_s)
  end

  numbers.each do |number|
    stickers << {
      team: team,
      number: number,
      category: category_for(team, number),
      position: position
    }
    position += 1
  end
end

Sticker.upsert_all(stickers, unique_by: :position)

puts "Seeded #{Sticker.count} stickers (shiny: #{Sticker.shiny.count}, coke: #{Sticker.coke.count}, normal: #{Sticker.normal.count})"
