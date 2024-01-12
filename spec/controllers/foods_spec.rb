require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { User.create!(name: 'Ye Min', email: 'yemin@hotmail.com', password: 'mystrongpassword') }

  before do
    sign_in user
  end

  describe 'index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'show' do
    let(:food) { Food.create!(user:, name: 'Tealeaf', measurement_unit: 'kg', price: 1000, quantity: 1) }

    it 'returns a success response' do
      get :show, params: { id: food.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create' do
    context 'with valid attributes' do
      it 'creates a new food item' do
        expect do
          post :create, params: { food: { name: 'Beef', measurement_unit: 'kg', price: 9, quantity: 2 } }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the created food item' do
        post :create, params: { food: { name: 'Beef', measurement_unit: 'kg', price: 9, quantity: 2 } }
        expect(response).to redirect_to(food_path(Food.last))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new food item' do
        expect do
          post :create, params: { food: { name: '', measurement_unit: '', price: nil, quantity: nil } }
        end.to_not change(Food, :count)
      end

      it 'renders the new template again' do
        post :create, params: { food: { name: '', measurement_unit: '', price: nil, quantity: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'destroy' do
    let!(:food_to_delete) { Food.create!(user:, name: 'Beef', measurement_unit: 'kg', price: 9, quantity: 2) }

    it 'deletes the food item if the current user owns it' do
      expect do
        delete :destroy, params: { id: food_to_delete.id }
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the food index page after the deletion' do
      delete :destroy, params: { id: food_to_delete.id }
      expect(response).to redirect_to(foods_path)
    end
  end
end
