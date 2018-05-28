Rails.application.routes.draw do
  root 'leagues#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :players
      resources :trades
    end
  end

  resources :teams, except: [:destroy, :create]

  resources :teams do
    resources :players
    resources :contracts
    resources :trades
  end

  resources :players do
    resources :contracts
    patch :add
    delete :drop
  end

  resources :trades

  resources :search, controller: 'players', only: [:new]

  resources :leagues, only: [:index, :show, :edit]


end
