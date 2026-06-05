class AddNameToStickers < ActiveRecord::Migration[8.1]
  def change
    add_column :stickers, :name, :string
  end
end
