Rails.application.routes.draw do
  
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  
  
  
  scope module: :public do
    
    devise_for :users, controllers: {
    sessions: 'public/sessions'
    }
    
    root to: "homes#top"
  
    get 'homes/about' => 'homes#about', as: 'about'
  
    devise_scope :user do
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end
    
    resources :users do
      member do
        get :likes
      end
    end
  
    resources :users, only: [:show, :edit, :update, :index] do
      resource :relationships, only: [:create, :destroy]
  	    get "followings" => "relationships#followings", as: "followings"
  	    get "followers" => "relationships#followers", as: "followers"  
    end
  
    resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resource :like, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      get :tags, on: :collection
    end
    
    patch 'post/:id/nonrelease' => 'posts#nonrelease', as: "nonrelease"
    patch 'post/:id/release' => 'posts#release', as: "release"
  
    resources :tags, only: [:index, :show]
  
    resources :likes, only: [:index]
    
   
    
    patch  '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
  
    get "/search", to: "searches#search"
  
  end
  
  devise_for :admin, skip: [:registrations], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    resources :dashboards, only: [:index, :update]
    
    resources :users, only: [:show, :update]
    
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    
    get 'users/:id/memory' => 'users#memory', as: 'memory'
    
    resources :posts, only: [:show, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
