class CreateRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_foods do |t|
      t.integer :quantity
      t.references :recipe, null: false, foreign_key: true
      t.references :food, null: true, foreign_key: true

      t.timestamps
    end
  end
end
