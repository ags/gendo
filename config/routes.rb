Gendo::Application.routes.draw do
  root "home#index"

  resources :transactions, only: [:index, :create, :show]

  resources :users, only: [:create]
  get "/sign-up", to: "users#new", as: :signup
  get "/sign-out", to: "sessions#destroy", as: :sign_out

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"

  if Rails.env.test?
    get "/bypass", to: "sessions#bypass", as: :bypass
  end
end
