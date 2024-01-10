Rails.application.routes.draw do
  resources :recipes
  resources :foods
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  root 'users#index'
  resources :users do
    resources :recipes do
      resources :recipe_food
    end
    resources :foods
  end
end
