Gendo::Application.routes.draw do
  constraints LoggedInConstraint.new do
    # Rails doesn't allow duplicate root names
    root "apps#index", as: :_authenticated_root
  end
  root "home#index"

  namespace :api_v1, path: "api/v1", defaults: {format: "json"} do
    resource :requests, only: [:create]
  end

  resources :apps, only: [:index, :new, :create, :show] do
    get :settings

    resources :sources, only: [:show]

    resources :requests, only: [:show]

    resources :n_plus_one_queries, only: [:show]

    resources :bulk_insertables, only: [:show]

    resources :mailer_events, only: [:show]
  end

  resources :users, only: [:create]

  namespace :oauth do
    resource :github, controller: :github, only: [] do
      get :authorize
      get :callback
    end
  end

  get "/sign-out", to: "sessions#destroy", as: :sign_out

  ## Engines

  unless Rails.env.test?
    require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
  end

  ## Test helpers

  if Rails.env.test?
    get "/bypass", to: "sessions#bypass", as: :bypass
  end
end
