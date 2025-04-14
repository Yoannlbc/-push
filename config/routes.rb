Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'loading', to: 'pages#loading'
  get 'home', to: 'pages#home'
  get "/profile", to: "users#profile"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resource :users, only: %i[edit update]
  resources :vinyls, only: %i[index new show create edit update]

  resources :vinyl_box, only: %i[show edit update]
end
