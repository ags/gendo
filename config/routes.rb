Gendo::Application.routes.draw do
  root 'home#index'

  resources :transactions, only: [:index, :create]
end
