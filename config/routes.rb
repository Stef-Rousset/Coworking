Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :buildings, only: [:new, :create, :show, :destroy] do
    resources :offices, only: [:index, :new, :create, :edit, :update]
  end
  resources :offices, only: [:destroy]
end
