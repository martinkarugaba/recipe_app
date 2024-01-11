Rails.application.routes.draw do
  resources :recipes
  resources :foods
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  resources :recipes do
    member do
      put 'toggle_public'
    end
  end

  root 'users#index'

  resources :users do
    resources :recipes
    resources :foods
  end
end
