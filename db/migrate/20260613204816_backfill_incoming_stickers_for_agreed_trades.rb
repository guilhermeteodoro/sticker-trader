class BackfillIncomingStickersForAgreedTrades < ActiveRecord::Migration[8.1]
  def up
    trade = Trade.where.not(user_a_accepted_at: nil)
                 .where.not(user_b_accepted_at: nil)
                 .order(:id).last

    return unless trade

    trade.transaction do
      trade.trade_stickers.includes(:sticker).each do |ts|
        # Soft-delete giver's duplicate (no-op if already discarded)
        ts.user_sticker&.discard

        # Create incoming row for receiver (skip if already exists)
        unless UserSticker.exists?(user_id: ts.receiver_id, sticker_id: ts.sticker_id, state: :incoming, trade_id: trade.id)
          UserSticker.create!(
            user_id: ts.receiver_id,
            sticker_id: ts.sticker_id,
            state: :incoming,
            trade_id: trade.id
          )
        end
      end
    end
  end

  def down
    trade = Trade.where.not(user_a_accepted_at: nil)
                 .where.not(user_b_accepted_at: nil)
                 .order(:id).last

    return unless trade

    UserSticker.where(trade_id: trade.id, state: :incoming).delete_all

    trade.trade_stickers.each do |ts|
      ts.user_sticker&.undiscard
    end
  end
end
