Rails.application.routes.draw do
  root to: 'api/v1/battles#index'
  namespace :api do
    namespace :v1 do
      resources :battles do
        resources :armies
        resources :battle_statuses
      end
    end
  end
end
