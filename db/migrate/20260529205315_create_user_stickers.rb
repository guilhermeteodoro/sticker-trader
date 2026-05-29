class CreateUserStickers < ActiveRecord::Migration[8.1]
  def change
    create_table :user_stickers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sticker, null: false, foreign_key: true
      t.integer :copies, null: false, default: 0

      t.timestamps
    end

    add_index :user_stickers, [:user_id, :sticker_id], unique: true
  end
end
