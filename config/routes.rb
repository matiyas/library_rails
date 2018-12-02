# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/:id', to: 'profiles#show', as: 'profile'
  # resources :posts
  root 'application#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  namespace :users do
    resources :posts
  end

  namespace :admins do
    resources :posts
  end

  namespace :api, :defaults => { :format => 'json' } do
    devise_for :users, controllers: {
      registrations: 'api/users/registrations',
      sessions: 'api/users/sessions',
      passwords: 'api/users/passwords',
      confirmations: 'api/users/confirmations'
    }

    namespace :admins do
      resources :posts
    end

    namespace :users do
      resources :posts
      resources :profiles
    end
  end

  match "*path", to: "users/posts#index", format: false, via: :get
end
