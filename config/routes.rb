# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  root 'posts#index'
  devise_scope :user do
    get 'users/profile/:id', to: 'users/registrations#show', as: 'user'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users
end
