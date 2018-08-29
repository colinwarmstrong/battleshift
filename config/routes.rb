Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/register', to: 'registration#new', as: :registration
  post '/users', to: 'registration#create'
  get '/dashboard', to: 'dashboard#show'
  get '/activation', to: 'activation#index', as: :activation
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show, :create] do
        post "/shots", to: "games/shots#create"
        post "/ships", to: "games/ships#create"
      end
    end
  end
end
