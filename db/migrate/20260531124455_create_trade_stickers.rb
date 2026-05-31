class CreateTradeStickers < ActiveRecord::Migration[8.1]
  def change
    create_table :trade_stickers do |t|
      t.references :trade, null: false, foreign_key: true
      t.references :sticker, null: false, foreign_key: true
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :trade_stickers, [ :trade_id, :sticker_id ], unique: true
  end
end
