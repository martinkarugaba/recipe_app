class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]
  # GET /recipes or /recipes.json
  def index
    if user_signed_in?
      @recipes = Recipe.includes(:user).order(created_at: :desc)
    else
      flash[:alert] = 'You need to sign up or sign in before continuing.'
      redirect_to new_user_registration_path
    end
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
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
    @recipe = current_user.recipes.find_by(id: params[:id])

    return if @recipe

    redirect_to recipes_url, alert: 'You do not have permission to access this recipe.'
  end

  def authorize_user!
    return unless @recipe.user != current_user

    redirect_to recipes_url, alert: 'You do not have permission to perform this action.'
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
