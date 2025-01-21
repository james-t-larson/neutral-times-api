Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  resources :articles, only: [ :index, :show ]

  namespace :v1 do
    resources :categories, only: [ :index, :show ] do
      resources :articles, only: [ :index ], controller: "articles"
    end
  end

  namespace :v2 do
    resources :articles, only: [ :index, :show ]
  end

  namespace :admin do
    resources :categories
    resources :prompts do
      collection do
        get "versions"
        get "versions/diff", to: "prompts#diff", as: "diff"
        get "versions/:id", to: "prompts#version", as: "version"
        get "versions/restore/:id", to: "prompts#restore", as: "restore"
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "articles#index"
end
