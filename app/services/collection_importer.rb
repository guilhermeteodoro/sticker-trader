# frozen_string_literal: true

# Takes parsed sticker data and creates/replaces a user's collection.
# Wipes existing user_stickers and bulk-inserts new ones.
class CollectionImporter
  def initialize(user, parsed_data)
    @user = user
    @owned = parsed_data[:owned]
    @duplicates = parsed_data[:duplicates]
  end

  def call
    sticker_positions = Sticker.where(position: @owned.to_a).pluck(:position, :id).to_h

    records = @owned.map do |position|
      sticker_id = sticker_positions[position]
      next unless sticker_id

      {
        user_id: @user.id,
        sticker_id: sticker_id,
        copies: @duplicates.fetch(position, 0),
        created_at: Time.current,
        updated_at: Time.current
      }
    end.compact

    UserSticker.transaction do
      @user.user_stickers.delete_all
      UserSticker.insert_all(records) if records.any?
    end
  end
end
