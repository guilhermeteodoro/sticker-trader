class AddGroupNameToCountries < ActiveRecord::Migration[8.1]
  def change
    add_column :countries, :group_name, :string
  end
end
