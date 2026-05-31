# frozen_string_literal: true

# == Schema Information
#
# Table name: user_stickers
#
#  id         :integer          not null, primary key
#  copies     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sticker_id :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_stickers_on_sticker_id              (sticker_id)
#  index_user_stickers_on_user_id                 (user_id)
#  index_user_stickers_on_user_id_and_sticker_id  (user_id,sticker_id) UNIQUE
#
# Foreign Keys
#
#  sticker_id  (sticker_id => stickers.id)
#  user_id     (user_id => users.id)
#
class UserSticker < ApplicationRecord
  belongs_to :user
  belongs_to :sticker

  validates :sticker_id, uniqueness: { scope: :user_id }
  validates :copies, numericality: { greater_than_or_equal_to: 0 }

  scope :duplicates, -> { where("copies > 0") }
end
