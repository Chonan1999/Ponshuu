Rails.application.routes.draw do
 
  devise_for :users

  root to: "tops#home"

  resources :users, only: [:index, :new, :create, :show, :edit, :update] do
    member do
      get :follows, :followers, :posts
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :posts do
    collection do
      get :confirm, :search
    end

    member do
      patch :publish
    end

    resources :comments, only: [:create, :destroy]
    resources :categories, only: [:index, :show]
  end

  get '/manifest.json', to: redirect('/assets/manifest.json')
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
