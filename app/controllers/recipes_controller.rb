class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def show; end

  def new
    @recipe = current_user.recipes.new
  end

  def edit; end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def new_recipe_food
    @recipe = Recipe.find(params[:id])
    @recipe_food = @recipe.recipe_foods.new

    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to @recipe, notice: 'Recipe food was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new_recipe_food, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_shopping_list
    @recipe = Recipe.find(params[:id])
    @user = current_user
    @general_food_list = @user.foods
    @missing_food_items = []

    @recipe.foods.each do |food|
      @missing_food_items << food unless @general_food_list.include?(food)
    end

    @user.shopping_list = @missing_food_items
    @user.save

    redirect_to shopping_list_user_path(@user)
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)

    respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Recipe visibility was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if @recipe.user == current_user
      @recipe.destroy
      respond_to do |format|
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to recipes_url, alert: 'You do not have permission to delete this recipe.'
    end
  end

  private

  def set_recipe
    if current_user
      @recipe = current_user.recipes.find_by(id: params[:id])

      redirect_to recipes_url, alert: 'You do not have permission to access this recipe.' unless @recipe
    else
      redirect_to new_user_session_path, alert: 'You need to sign in to perform this action.'
    end
  end

  def authorize_user!
    return unless @recipe.user != current_user

    redirect_to recipes_url, alert: 'You do not have permission to perform this action.'
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
