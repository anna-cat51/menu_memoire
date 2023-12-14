Rails.application.routes.draw do
  root "tops#index"

  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks",
  sessions: "sessions"
}

  resources :repertoires
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  post '/callback', to: 'linebot#callback'

  get '/scrapers/index', to: 'scrapers#index'
  post '/scrapers/scrape', to: 'scrapers#scrape'
end
