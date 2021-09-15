Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:show] do
        resources :subscriptions, only: [:create, :index] do
          resources :teas, only: [:create]
        end
      end
    end
  end
end