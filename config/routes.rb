Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :buildings, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :offices, only: [:index, :new, :create]
  end
  resources :offices, only: [:edit, :update, :destroy]
end
