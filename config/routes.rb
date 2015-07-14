Rails.application.routes.draw do
  namespace :api do
    resources :urls, only: [:create]

    get 'urls' => 'urls#show'
  end

  root 'urls#index'

  resources :urls, only: [:create]

  get 'urls' => 'urls#show'
end
