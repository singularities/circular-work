Rails.application.routes.draw do
  root :to => 'assets#index'
  get 'assets/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
