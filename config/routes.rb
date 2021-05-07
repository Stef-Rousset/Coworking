Rails.application.routes.draw do
  devise_for :users

  scope "(:locale)", locale: /en|fr/ do
    root to: 'pages#home'
    get '/dashboard', to: 'pages#dashboard'
    get '/building_stats_as_pdf', to: 'pages#building_stats_as_pdf'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :buildings, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :offices, only: [:index, :new, :create]
    end
    resources :offices, only: [:show, :edit, :update, :destroy] do
      resources :discounts, only: [:create]
      resources :bookings, only: [:create]
    end
    resources :discounts, only: [:destroy]
  end
end
