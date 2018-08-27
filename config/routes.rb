Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/register', to: 'registration#new', as: :registration
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end
    end
  end
end
