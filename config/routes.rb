Rails.application.routes.draw do
  root 'teams#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :players
      resources :trades
    end
  end

  resources :teams do
    resources :players
  end

  resources :teams do
    resources :trades
  end

  resources :players do
    patch :add
  end

  resources :trades

end
