Rails.application.routes.draw do
  resources :catalogs
  resources :products

  root 'catalogs#index'
end
