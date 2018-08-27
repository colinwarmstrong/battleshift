Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/register', to: 'registration#new', as: :registration
  post '/users', to: 'registration#create'
  get '/dashboard', to: 'dashboard#show'
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end
    end
  end
end
