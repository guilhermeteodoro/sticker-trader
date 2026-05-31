# frozen_string_literal: true

class Trade < ApplicationRecord
  belongs_to :user_a, class_name: "User"
  belongs_to :user_b, class_name: "User"

  has_many :trade_stickers, dependent: :destroy

  def confirmed?
    confirmed_at.present?
  end

  def stickers_given_by(user)
    trade_stickers.includes(sticker: :country).where(giver: user).map(&:sticker)
  end

  def stickers_received_by(user)
    trade_stickers.includes(sticker: :country).where(receiver: user).map(&:sticker)
  end
end
