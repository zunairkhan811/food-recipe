Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users
  resources :recipes
  resources :recipe_foods
  resources :foods

  root 'homes#index'
end
