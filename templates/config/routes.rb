# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    # Redirests signing out users back to sign-in
    get 'users', to: 'devise/sessions#new'
  end

  get :health, to: 'application#health'

  namespace :api, defaults: { format: :json } do
    get :health, to: 'application#health'
  end
end
