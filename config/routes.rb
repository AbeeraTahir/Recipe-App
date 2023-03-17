Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :foods
  resources :recipes do
    resources :recipe_foods
  end
  
  resources :shoppinglists

  resources :public_recipes
  post 'toggle_public', to: 'recipes#toggle'
  
  root "foods#index"
end
