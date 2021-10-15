Rails.application.routes.draw do
  get 'accounts/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "accounts#index" 
end
