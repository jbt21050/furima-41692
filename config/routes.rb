Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  resources :products do
    resources :records, only: [:index, :create]
  end
end    
