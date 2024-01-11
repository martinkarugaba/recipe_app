class DropRecipeFoodsAndRecipes < ActiveRecord::Migration[7.1]
  def up
    drop_table :recipe_foods
    drop_table :recipes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
