Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/update'
  # Devise routes for User and AdminUser
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Static pages
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  
  # Product routes
  root to: 'products#index' # Sets the products index as the front page
  resources :products, only: [:index, :show] # Combines index and show routes for products

  # Cart routes
  get 'cart', to: 'cart#show', as: 'cart'

  post 'cart/items/:product_id', to: 'cart#add_item', as: 'cart_add'
  patch 'cart/items/:product_id', to: 'cart#update_item', as: 'update_cart_item'
  delete 'cart/items/:product_id', to: 'cart#remove_item', as: 'remove_cart_item'

  #user profile routes
  resource :profile, only: [:show, :edit, :update]
  resources :profiles, only: [:show, :edit, :update] 

  #order route
  resources :orders, only: [:new, :create, :show]
  resources :orders, only: [:index, :show]  # Ensures users can list and view individual orders

  

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
