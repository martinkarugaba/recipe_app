require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'Validations' do
    let(:user_instance) { User.create(email: 'user_test@example.com', password: 'user_password') }

    context 'with valid attributes' do
      it 'is valid' do
        recipe = Recipe.new(
          name: 'Delicious Dish',
          preparation_time: '25 mins',
          cooking_time: '40 mins',
          description: 'A tasty dish description',
          user: user_instance
        )
        expect(recipe).to be_valid
      end
    end

    context 'with invalid attributes' do
      it 'is not valid without a name' do
        recipe = Recipe.new(
          preparation_time: '25 mins',
          cooking_time: '40 mins',
          description: 'A tasty dish description',
          user: user_instance
        )
        expect(recipe).to_not be_valid
        expect(recipe.errors[:name]).to include("can't be blank")
      end

      it 'is not valid without preparation_time' do
        recipe = Recipe.new(
          name: 'Delicious Dish',
          cooking_time: '40 mins',
          description: 'A tasty dish description',
          user: user_instance
        )
        expect(recipe).to_not be_valid
        expect(recipe.errors[:preparation_time]).to include("can't be blank")
      end

      it 'is not valid without cooking_time' do
        recipe = Recipe.new(
          name: 'Delicious Dish',
          preparation_time: '25 mins',
          description: 'A tasty dish description',
          user: user_instance
        )
        expect(recipe).to_not be_valid
        expect(recipe.errors[:cooking_time]).to include("can't be blank")
      end

      it 'is not valid without a description' do
        recipe = Recipe.new(
          name: 'Delicious Dish',
          preparation_time: '25 mins',
          cooking_time: '40 mins',
          user: user_instance
        )
        expect(recipe).to_not be_valid
        expect(recipe.errors[:description]).to include("can't be blank")
      end
    end
  end
end
