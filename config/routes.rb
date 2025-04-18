Rails.application.routes.draw do
  devise_for :users

  # Root pour les users connectés
  authenticated :user do
    root to: "vinyl_boxes#show", as: :authenticated_root
  end

  # Root par défaut
  root to: "pages#home"

  # Pages statiques
  get 'loading', to: 'pages#loading'
  get 'home', to: 'pages#home'

  # Profil utilisateur
  get "/profile", to: "users#profile"
  resource :users, only: %i[edit update]

  # Vinyls
  resources :vinyls, only: %i[index new show create edit update destroy]

  # Bac à vinyles
  resource :vinyl_box, only: [:show]
  get "/dashboard", to: "vinyl_boxes#show", as: :dashboard

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
