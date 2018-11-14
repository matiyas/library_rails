Rails.application.routes.draw do
  resources :posts
  get 'static_pages/home'
  # devise_for :users
  root 'posts#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
