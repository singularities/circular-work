Rails.application.routes.draw do
  mount_ember_app :frontend, to: "/"

  resources :tasks
  resources :turns
  resources :groups

  unless ENV['PRECOMPILE']
    devise_for :users, controllers: { sessions: 'users/sessions' }
  end
end
