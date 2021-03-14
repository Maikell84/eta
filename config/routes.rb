Rails.application.routes.draw do
  resources :home

        devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  root to: "home#index"

  resources :storages
end
