Rails.application.routes.draw do

  root 'rooms#index'

  get 'sign_up' => 'users#new', as: :sign_up
  get 'sign_in' => 'sessions#new', as: :sign_in
  post 'logout' => 'sessions#destroy', as: :logout

  get '/profile/(:id)' => 'users#show', as: :profile

  resources :users, except: :destroy
  resources :sessions, only: [:new, :create, :destroy]
  resources :rooms
  resources :members, only: :create

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
