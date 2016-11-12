Rails.application.routes.draw do
  mount_ember_app :frontend, to: "/"

  resources :tasks
  resources :turns
  resources :groups

  devise_for :users
end
