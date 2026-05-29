# frozen_string_literal: true

Rails.application.routes.draw do
  root "pages#home"

  resource :registration, only: [:new, :create]

  get "/u/:slug", to: "collections#show", as: :collection
  get "/u/:slug/edit", to: "collections#edit", as: :edit_collection
  patch "/u/:slug", to: "collections#update", as: :update_collection

  get "up" => "rails/health#show", as: :rails_health_check
end
