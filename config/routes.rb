Rails.application.routes.draw do
  get 'static_pages/about'
  get 'static_pages/contact'

  # Static pages
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  

  get 'products/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'products#index' # Sets the products index as the front page
  resources :products, only: [:index] # This enables the products_path helper
  
  get 'cart', to: 'cart#show'

  post 'cart/items/:product_id', to: 'cart#add_item', as: 'cart_add'
  patch 'cart/items/:product_id', to: 'cart#update_item', as: 'update_cart_item'
  delete 'cart/items/:product_id', to: 'cart#remove_item', as: 'remove_cart_item'



  # Route for product details page
  get 'products/:id', to: 'products#show', as: 'product'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
