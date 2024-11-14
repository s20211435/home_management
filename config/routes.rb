# frozen_string_literal: true

Rails.application.routes.draw do
  get "users/index"
  get "/login", to: "sessions#new", as:  "new_session"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  resources :user do
    resources :schedules, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  end

  root "sessions#new"
end
