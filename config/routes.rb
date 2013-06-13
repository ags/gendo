Gendo::Application.routes.draw do
  root "home#index"

  resources :transactions, only: [:index, :create, :show]

  resources :users, only: [:create]
  get "/sign-up", to: "users#new", as: :signup

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
end
