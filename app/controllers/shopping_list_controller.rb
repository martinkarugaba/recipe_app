class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipe = Recipe.first
    @shopping_list_items = generate_shopping_list(@user, @recipe)
  end

  private

  def generate_shopping_list(user, recipe)
    @user = user
    @recipe = recipe
    @shopping_list_items = generate_shopping_list_items(@user, @recipe)
    render 'shopping_list/index'
  end

  def generate_shopping_list_items(user, recipe)
    missing_food = []

    recipe.foods.each do |food|
      missing_food << food unless user.foods.exists?(id: food.id)
    end

    missing_food
  end
end
