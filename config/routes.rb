Gendo::Application.routes.draw do
  root "home#index"

  resources :apps, only: [:new, :create, :show]

  resources :transactions, only: [:index, :create, :show]

  resources :users, only: [:create]

  get "/sign-up", to: "users#new", as: :signup
  get "/sign-out", to: "sessions#destroy", as: :sign_out

  get "/sign-in", to: "sessions#new", as: :sign_in
  post "/sign-in", to: "sessions#create"

  if Rails.env.test?
    get "/bypass", to: "sessions#bypass", as: :bypass
  end
end
