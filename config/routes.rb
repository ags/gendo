Gendo::Application.routes.draw do
  constraints LoggedInConstraint.new do
    # Rails doesn't allow duplicate root names
    root "apps#index", as: :_authenticated_root
  end
  root "home#index"

  namespace :api_v1, path: "api/v1", defaults: {format: "json"} do
    resource :requests, only: [:create]
  end

  namespace :oauth do
    resource :github, controller: :github, only: [] do
      get :authorize
      get :callback
    end
  end

  resource :account, only: [:update] do
    get :settings
  end

  resources :apps, only: [:index, :new, :create, :show] do
    get :settings

    resources :counter_cacheable_query_sets, only: [:show]

    resources :sources, only: [:show]

    resources :requests, only: [:show]

    resources :n_plus_one_queries, only: [:show]

    resources :bulk_insertables, only: [:show]

    resources :mailer_events, only: [:show]
  end

  get "/sign-out", to: "sessions#destroy", as: :sign_out

  ## Engines

  unless Rails.env.test?
    require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
  end

  ## Development helpers

  unless Rails.env.production?
    get "/sign_in_as", to: "development#sign_in_as", as: :sign_in_as
  end
end
