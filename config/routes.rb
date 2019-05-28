Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # root to: "groups#index"
  # namespace :user do
  #   root :to => "pages#home"
  # end

  resources :groups do
    resources :lists
    resources :group_memberships, only: [:new, :create, :destroy]
  end
  resources :users
  resources :list_items

  mount ActionCable.server => "/cable"

  resources :conversations, only: [:show] do
    resources :messages, only: [:create]
  end

end
