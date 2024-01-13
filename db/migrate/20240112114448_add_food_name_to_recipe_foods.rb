class AddFoodNameToRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    add_column :recipe_foods, :food_name, :string
  end
end
