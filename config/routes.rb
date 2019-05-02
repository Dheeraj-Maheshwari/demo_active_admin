Rails.application.routes.draw do
  root 'products#index'
  get 'new' => 'charges#new'
  post 'checkout_payment' => 'charges#checkout_payment'
  resources :charges,:products#, only: [:new, :create]
  get 'express', to: 'products#express'
  get 'products/complete'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

