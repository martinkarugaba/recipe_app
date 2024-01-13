# app/controllers/shopping_list_controller.rb

class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @shopping_list_items = generate_shopping_list(@user)
  end

  def generate_shopping_list
    @recipe = Recipe.find(params[:id])
    @user = current_user
    @shopping_list_items = generate_shopping_list_items(@user, @recipe)

    render 'shopping_list/index'
  end

  private

  def generate_shopping_list_items(user, recipe)
    missing_food = []

    recipe.foods.each do |food|
      # Check if the user already has the food in their general food list
      missing_food << food unless user.foods.exists?(id: food.id)
    end

    missing_food
  end
end
