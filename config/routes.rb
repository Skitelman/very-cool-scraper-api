Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      resources :sales, only: [:index]
      resources :rentals, only: [:index]
    end
  end
end
