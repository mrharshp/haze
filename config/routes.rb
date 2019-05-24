Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :groups do
    resources :lists
  end
  resources :users
end
