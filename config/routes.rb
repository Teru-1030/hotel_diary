Rails.application.routes.draw do
  
  #devise_for :users, controllers: {
    #sessions: 'users/sessions'
  #}
  
  
  
  scope module: :public do
    devise_for :users, controllers: {
    sessions: 'public/sessions'
    }
  
    root to: "homes#top"
  
    get 'homes/about' => 'homes#about', as: 'about'
  
    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
  
    resources :users, only: [:show, :edit, :update, :index]
  
    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :comments, only: [:create, :destroy]
    end
  
    resources :tags, only: [:index, :show]
  
    resources :likes, only: [:index]
  
    patch  '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
  
    get "/search", to: "searches#search"
  
  end
  
  devise_for :admin, skip: [:registrations], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    resources :dashboards, only: [:index]
    
    resources :users, only: [:show]
    
    patch 'admin/users/:id/withdraw' => 'users#withdraw', as: 'admin_withdraw'
    
    get 'admin/users/memory' => 'users#memory', as: 'memory'
    
    resources :posts, only: [:show, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
