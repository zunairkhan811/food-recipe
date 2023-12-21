Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users
  resources :recipes
  resources :recipe_foods
  resources :foods

  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'

  root 'homes#index'
  
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
end
