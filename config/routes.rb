Rails.application.routes.draw do
  resources :posts
  get 'static_pages/home'
  devise_for :users
  resources :books
  root 'static_pages#home'
  # devise_for :users, controllers: {
  #     sessions: 'users/registrations'
  # }
end
