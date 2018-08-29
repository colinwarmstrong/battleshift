Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/register', to: 'registration#new', as: :registration
  post '/users', to: 'registration#create'
  get '/dashboard', to: 'dashboard#show'
  get '/activation', to: 'activation#index', as: :activation
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show, :create] do
        post "/shots", to: "games/shots#create"
      end
    end
  end
end
