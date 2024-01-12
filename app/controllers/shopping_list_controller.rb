class ShoppingListController < ApplicationController
  def index
    @missing_foods = current_user.shopping_list
  end
end
