# frozen_string_literal: true

Rails.application.routes.draw do
  root "pages#home"

  resource :registration, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :collections, path: "u", param: :slug, only: [:show, :edit, :update]

  get "up" => "rails/health#show", as: :rails_health_check
end
