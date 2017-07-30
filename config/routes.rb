Rails.application.routes.draw do
  resources :products do
    collection do
      get :partial_index
    end
  end
  resources :rate_plans

  namespace :api do
    resources :products, only: [:index, :show]
  end

  root 'products#index'
end
