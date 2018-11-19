# frozen_string_literal: true

Rails.application.routes.draw do
  get 'profiles/:id', to: 'profiles#show', as: 'profile'
  resources :posts
  root 'posts#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
