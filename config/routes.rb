Rails.application.routes.draw do
  resources :searches, only: [:index]
  root "tops#index"
  get '/terms_of_use', to: 'tops#terms_of_use'
  get '/privacy_policy', to: 'tops#privacy_policy'
  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks",
  sessions: "sessions"
}

  resources :repertoires do
    collection do
      post :scrape
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/callback', to: 'linebot#callback'

end
