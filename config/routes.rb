Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # namespace :user do
  #   root :to => "pages#home"
  # end

  resources :groups do
    resources :lists
    resources :group_memberships, only: [:new, :create, :destroy]
  end
  resources :users
  resources :list_items
end
