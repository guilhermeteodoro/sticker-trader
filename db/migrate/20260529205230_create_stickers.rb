class CreateStickers < ActiveRecord::Migration[8.1]
  def change
    create_table :stickers do |t|
      t.string :team, null: false
      t.string :number, null: false
      t.integer :category, null: false
      t.integer :position, null: false
    end

    add_index :stickers, :position, unique: true
    add_index :stickers, [:team, :number], unique: true
    add_index :stickers, :category
  end
end
