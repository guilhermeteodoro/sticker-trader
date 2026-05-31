# frozen_string_literal: true

class TradeSticker < ApplicationRecord
  belongs_to :trade
  belongs_to :sticker
  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sticker_id, uniqueness: { scope: :trade_id }
end
