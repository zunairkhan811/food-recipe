Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users
  resources :recipes
  resources :recipe_foods
  resources :foods
  resources :shopping_lists


  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
  get '/general_shopping_list', to: 'shopping_lists#index', as: 'general_shopping_list'

  root 'foods#index'

  
  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
end
