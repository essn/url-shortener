Rails.application.routes.draw do
  root 'urls#index'

  resources :urls, only: [:create]

  get 'urls' => 'urls#show'
end
