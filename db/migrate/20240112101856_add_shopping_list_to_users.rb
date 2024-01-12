class AddShoppingListToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :shopping_list, :jsonb
  end
end
