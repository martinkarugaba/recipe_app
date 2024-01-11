Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :recipes do
    put 'toggle_public', on: :member
    get 'public_recipes', on: :collection
    get 'new_recipe_food', on: :member
    post 'create_new_recipe_food', on: :member
    post 'generate_shopping_list', on: :member

    resources :recipe_foods
  end

  resources :foods

  root 'foods#index'
end
