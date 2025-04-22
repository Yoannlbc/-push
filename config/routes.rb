Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "vinyl_boxes#show", as: :authenticated_root
  end

  root to: "pages#home"

  get 'loading', to: 'pages#loading'
  get 'home', to: 'pages#home'

  get "/profile", to: "users#profile"
  resource :users, only: %i[edit update]

  resource :user, only: [] do
    patch :update_photo
    delete :remove_photo
  end

  resources :vinyls, only: %i[index new show create edit update destroy]

  resource :vinyl_box, only: [:show]
  get "/dashboard", to: "vinyl_boxes#show", as: :dashboard

  get "up" => "rails/health#show", as: :rails_health_check
end
