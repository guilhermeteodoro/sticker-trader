# frozen_string_literal: true

class UserSticker < ApplicationRecord
  belongs_to :user
  belongs_to :sticker

  validates :sticker_id, uniqueness: { scope: :user_id }
  validates :copies, numericality: { greater_than_or_equal_to: 0 }

  scope :duplicates, -> { where("copies > 0") }
end
