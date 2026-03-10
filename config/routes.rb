Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      get '/jobs', to: 'jobs#index'
      get '/jobs/:id', to: 'jobs#show'
      post '/scrape', to: 'jobs#scrape'
      patch '/jobs/"id', to: 'jobs#patch'
    end
  end
end
