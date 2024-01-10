class FoodsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_food, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    unless user_signed_in?
      flash[:alert] = 'You need to sign up or sign in before continuing.'
      redirect_to new_user_registration_path
      return
    end

    @foods = Food.all
  end

  # GET /foods/1 or /foods/1.json
  def show
    @food = Food.find(params[:id])
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods or /foods.json
  def create
    @food = current_user.foods.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to food_url(@food), notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @food.user == current_user
      @food.destroy!
      respond_to do |format|
        format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to foods_url, alert: 'You do not have permission to delete this food.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
