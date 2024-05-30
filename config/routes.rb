Rails.application.routes.draw do
  resources :groups
  resources :menus
  resources :restaurant_profiles, except: %i[index destroy]
  devise_for :users, path_prefix: 'devise'
  devise_for :businesses, path_prefix: 'devise'
  resources :businesses, only: :show
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "/for_business", to: "static_pages#for_business"
  get "/about_us", to: "static_pages#about_us"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
