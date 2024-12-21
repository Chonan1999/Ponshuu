Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  get "comments/create"
  get "comments/destroy"
  get '/manifest.json', to: redirect('/assets/manifest.json')
  get 'posts/search', to: 'posts#search', as: 'search_posts'
  root to: "tops#home"
  # get 'users/posts', to: 'posts#index', as: 'users_posts'
  devise_for :users
  resources :users, only: [:index, :new, :create, :show, :edit, :update] do
    member do
      get :followers, :followings, :posts
    end
  end

  resources :relationships, only: [:create, :destroy]
  
  resources :posts do
    collection do
      get :confirm, :search
    end

    member do
      patch :publish
    end
    
    resources :comments, only: [ :create, :destroy ]
    resources :categories, only: [:index, :show]

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
