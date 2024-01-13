require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @user = User.create!(name: 'Ye Min', email: 'yemin@hotmail.com', password: 'StrongPassword')
    @recipe = Recipe.create!(
      user: @user,
      name: 'myanmar curry',
      preparation_time: '30 minutes',
      cooking_time: '1 hour',
      description: 'Delicious myanmar curry recipe'
    )
    sign_in @user
  end

  describe 'index' do
    it 'renders template' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'show' do
    it 'renders the show template' do
      get :show, params: { id: @recipe.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end

  describe 'new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'edit' do
    it 'renders the edit template' do
      get :edit, params: { id: @recipe.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'create' do
    context 'with valid attributes' do
      it 'creates a new recipe' do
        expect do
          post :create,
               params: { recipe: { name: 'Beef', preparation_time: '30 minutes', cooking_time: '2 hours',
                                   description: 'Tasty beef recipe' } }
        end.to change(Recipe, :count).by(1)
      end

      it 'redirects to the recipes index page after creation' do
        post :create,
             params: { recipe: { name: 'Myanmar curry', preparation_time: '45 minutes', cooking_time: '2 hours',
                                 description: 'Tasty myanmar dish recipe' } }
        expect(response).to redirect_to(recipes_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new recipe' do
        expect do
          post :create, params: { recipe: { name: '', preparation_time: '', cooking_time: '', description: '' } }
        end.not_to change(Recipe, :count)
      end

      it 're-renders the new template' do
        post :create, params: { recipe: { name: '', preparation_time: '', cooking_time: '', description: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'update' do
    it 'updates the recipe' do
      patch :update, params: { id: @recipe.id, recipe: { name: 'Updated beef Curry' } }
      @recipe.reload
      expect(@recipe.name).to eq('Updated beef Curry')
    end

    it 'redirects to the updated recipe' do
      patch :update, params: { id: @recipe.id, recipe: { name: 'Updated beef Curry' } }
      expect(response).to redirect_to(@recipe)
    end
  end

  describe 'destroy' do
    it 'deletes the recipe' do
      expect do
        delete :destroy, params: { id: @recipe.id }
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes index page after deletion' do
      delete :destroy, params: { id: @recipe.id }
      expect(response).to redirect_to(recipes_path)
    end
  end
end
