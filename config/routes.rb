Rails.application.routes.draw do
  devise_for :user, :controllers => {:registrations => "registrations"}
  as :user do
  	get '/account/:tab' => 'registrations#edit', as: :user_account
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "accounts#index"

  resources :accounts
  resources :users
  resources :rate_cards
  resources :payment_requests do
    collection do
      post :upload
    end
  end
end
