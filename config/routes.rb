Gendo::Application.routes.draw do
  root "home#index"

  resources :transactions, only: [:index, :create, :show]

  resources :users, only: [:create]
  get "/sign-up", to: "users#new", as: :signup
end
