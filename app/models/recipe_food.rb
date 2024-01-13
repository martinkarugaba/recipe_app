class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  def total_price
    recipe_foods.sum { |recipe_food| recipe_food.food.price }
  end
end
