Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # root to: "groups#index"
  # namespace :user do
  #   root :to => "pages#home"
  # end
  resources :groups do
    resources :lists do
      resources :list_items
    end
    resources :group_memberships, only: [:new, :create, :destroy]
  end
  resources :users
  resources :list_items do
    member do
      post "/upvote", to: "list_items#upvote"
      post "/downvote", to: "list_items#downvote"
    end
  end
end
