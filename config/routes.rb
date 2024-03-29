Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :recipes do
    put 'toggle_public', on: :member
    get 'public_recipes', on: :collection
    post 'generate_shopping_list', on: :member

    resources :recipe_foods
  end

  resources :foods
  resources :shopping_list

  resources :users do
    get 'shopping_list', on: :member
  end

  root 'foods#index'
end
