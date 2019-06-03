Rails.application.routes.draw do

  get 'votes/create'
  post 'groups/invite'
  devise_for :users
  root to: "pages#home"
  # root to: "groups#index"
  # namespace :user do
  #   root :to => "pages#home"
  # end
  resources :groups do
    resources :expenses
    resources :lists do
      resources :list_items
    end
    resources :group_memberships, only: [:new, :create, :destroy]
  end
  resources :users

  mount ActionCable.server => "/cable"

  resources :conversations, only: [:show] do
    resources :messages, only: [:create]
  end

  resources :list_items do
    member do
      post "/upvote", to: "list_items#upvote"
      post "/downvote", to: "list_items#downvote"
    end
    resources :votes, only: [:create]
  end
end
