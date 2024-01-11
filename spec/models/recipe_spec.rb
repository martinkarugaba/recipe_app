require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user_instance) { User.create(email: 'user_test@example.com', password: 'user_password') }

  describe 'Validations' do
    context 'with valid attributes' do
      it 'is valid' do
        recipe = Recipe.new(
          name: 'Sample Recipe',
          preparation_time: '25 mins',
          cooking_time: '40 mins',
          description: 'A tasty dish description',
          user: user_instance
        )
        expect(recipe).to be_valid
      end
    end

    context 'with invalid attributes' do
      before do
        @invalid_recipe = Recipe.new(user: user_instance)
      end

      it 'is not valid without a name' do
        expect(@invalid_recipe).to_not be_valid
        expect(@invalid_recipe.errors[:name]).to include("can't be blank")
      end

      it 'is not valid without preparation_time' do
        expect(@invalid_recipe).to_not be_valid
        expect(@invalid_recipe.errors[:preparation_time]).to include("can't be blank")
      end

      it 'is not valid without cooking_time' do
        expect(@invalid_recipe).to_not be_valid
        expect(@invalid_recipe.errors[:cooking_time]).to include("can't be blank")
      end

      it 'is not valid without a description' do
        expect(@invalid_recipe).to_not be_valid
        expect(@invalid_recipe.errors[:description]).to include("can't be blank")
      end
    end
  end
end
