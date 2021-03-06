# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/:id', to: 'profiles#show', as: 'profile'
  # resources :posts
  root 'users/posts#index'
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
end
