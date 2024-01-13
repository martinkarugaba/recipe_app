class UsersController < ApplicationController
  def index; end
  def show; end

  def shopping_list
    @user = User.find(params[:id])
    @recipes = @user.recipes
    @general_food_list = @user.foods
    @missing_food_items = []

    @recipes.each do |recipe|
      recipe.foods.each do |food|
        @missing_food_items << food unless @general_food_list.include?(food)
      end
    end

    @total_items = @missing_food_items.count
    @total_price = @missing_food_items.sum(&:price)
  end
end
