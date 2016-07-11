Rails.application.routes.draw do
  devise_for :accounts

  resources :readers
  resources :items
  resources :carts
  resources :tags
  resources :readings
  resources :stores

  get :dashboard, to: "pages#show", id: "dashboard"
  root "pages#show", id: "landing"
end
