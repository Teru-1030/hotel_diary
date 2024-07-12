Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :users, only: [:show, :edit]
  resources :posts, only: [:new, :index, :show, :edit, :create]
  resources :tags, only: [:index, :show]
  resources :comments, only: [:index, :show]
  resources :likes, only: [:index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
