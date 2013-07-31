Gendo::Application.routes.draw do
  root "home#index"

  namespace :api_v1, path: 'api/v1', defaults: {format: 'json'} do
    resource :transactions, only: [:create]
  end

  resources :apps, only: [:index, :new, :create, :show] do
    get :settings

    resources :sources, only: [:show]

    resources :transactions, only: [:show]

    resources :n_plus_one_queries, only: [:show]
  end

  resources :users, only: [:create]

  get "/sign-up", to: "users#new", as: :signup
  get "/sign-out", to: "sessions#destroy", as: :sign_out

  get "/sign-in", to: "sessions#new", as: :sign_in
  post "/sign-in", to: "sessions#create"

  if Rails.env.test?
    get "/bypass", to: "sessions#bypass", as: :bypass
  end
end
