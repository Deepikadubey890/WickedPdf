Rails.application.routes.draw do
  resources :inboxes
  # get 'invoices/index'
  # get 'invoices/show'
  root to: 'invoices#index'
  resources :invoices, only: [:new, :create, :index, :show]
end
