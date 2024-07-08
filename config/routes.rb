Rails.application.routes.draw do
  get 'likes/index'
  get 'comments/index'
  get 'comments/show'
  get 'tags/index'
  get 'tags/show'
  get 'posts/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  devise_for :users
  root to: "homes#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
