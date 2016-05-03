Rails.application.routes.draw do
  resources :sequences, only: [:index, :create]
  root 'sequences#index'
end
