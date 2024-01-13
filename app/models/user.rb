class User < ApplicationRecord
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :foods, dependent: :destroy
  has_many :recipes

  def shopping_list
    # Get all the food objects associated with the user's recipes
    recipe_foods = recipes.joins(:recipe_foods).pluck(:food_id)

    # Get all the food objects in the recipe_foods list that are not in the general list
    Food.where(id: recipe_foods).where.not(id: foods.pluck(:id))

    # Return the missing foods
  end
end
