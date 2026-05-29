# frozen_string_literal: true

class Sticker < ApplicationRecord
  enum :category, { shiny: 0, coke: 1, normal: 2 }

  validates :team, presence: true
  validates :number, presence: true, uniqueness: { scope: :team }
  validates :category, presence: true
  validates :position, presence: true, uniqueness: true

  scope :ordered, -> { order(:position) }

  def label
    "#{team} #{number}"
  end
end
