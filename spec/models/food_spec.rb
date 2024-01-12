require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'Validations' do
    let(:user) { User.create(email: 'sample@email.com', password: 'test123') }

    context 'when all attributes are present' do
      let(:valid_food) do
        Food.new(name: 'Delicious Dish', measurement_unit: 'units', price: 9.99, quantity: 100, user:)
      end

      it 'is valid' do
        expect(valid_food).to be_valid
      end
    end

    context 'when attributes are missing' do
      it 'requires a name' do
        food = Food.new(measurement_unit: 'units', price: 9.99, quantity: 100)
        expect(food).to_not be_valid
        expect(food.errors[:name]).to include("can't be blank")
      end

      it 'requires a measurement unit' do
        food = Food.new(name: 'Tasty Treat', price: 9.99, quantity: 100)
        expect(food).to_not be_valid
        expect(food.errors[:measurement_unit]).to include("can't be blank")
      end

      it 'requires a price' do
        food = Food.new(name: 'Tasty Treat', measurement_unit: 'units', quantity: 100)
        expect(food).to_not be_valid
        expect(food.errors[:price]).to include("can't be blank")
      end

      it 'requires a quantity' do
        food = Food.new(name: 'Tasty Treat', measurement_unit: 'units', price: 9.99)
        expect(food).to_not be_valid
        expect(food.errors[:quantity]).to include("can't be blank")
      end
    end
  end

  describe 'Associations' do
    it 'is associated with a user' do
      reflection = described_class.reflect_on_association(:user)
      expect(reflection.macro).to eq(:belongs_to)
    end

    it 'has many recipe foods and destroys dependent associations' do
      reflection = described_class.reflect_on_association(:recipe_foods)
      expect(reflection.macro).to eq(:has_many)
      expect(reflection.options).to include(dependent: :destroy)
    end

    it 'has many recipes through recipe foods' do
      reflection = described_class.reflect_on_association(:recipes)
      expect(reflection.macro).to eq(:has_many)
      expect(reflection.options).to include(:through)
    end
  end
end
