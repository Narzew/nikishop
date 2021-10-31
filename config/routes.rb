# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :products do
    collection do
      get :search
      get :show_cart
      get :finalize_transaction
    end
    member do
      get :add_to_cart
      get :remove_from_cart
    end
  end
end
