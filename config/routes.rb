Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # namespace :user do
  #   root :to => "pages#home"
  # end

  resources :groups do
    resources :lists
  end
  resources :users
end
