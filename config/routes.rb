Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :statistics
  resources :home, only: [:index]
  resources :storages
  resources :consumptions
  resources :users
  resources :ashes
  resources :states, only: [:index]
end
