# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :doctors, only: [:index] do
        collection do
          get 'all_data' 
        end
      end
      get 'doctors/by_city', to: 'doctors#by_city'
      post 'doctors', to: 'doctors#create'
      resources :services, only: [:index] 
      resources :establishments, only: [:index] 

     
      get 'establishments/by_city', to: 'establishments#by_city'
     
      get 'services/by_city', to: 'services#by_city'
    end
  end
end
