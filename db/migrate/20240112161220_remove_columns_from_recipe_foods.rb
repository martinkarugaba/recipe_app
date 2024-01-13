class RemoveColumnsFromRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipe_foods, :food_name, :string
    remove_column :recipe_foods, :price, :decimal
  end
end
