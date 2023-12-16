Rails.application.routes.draw do
  root "tops#index"

  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks",
  sessions: "sessions"
}

  resources :repertoires
  post 'repertoires/scrape', to: 'repertoires#scrape'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  post '/callback', to: 'linebot#callback'

end
