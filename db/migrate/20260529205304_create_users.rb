class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
    add_index :users, :slug, unique: true
    add_index :users, :email, unique: true
  end
end
