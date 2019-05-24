Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :groups do
    resources :lists
    resources :group_memberships, only: [:new, :create, :destroy]
  end
  resources :users
end
