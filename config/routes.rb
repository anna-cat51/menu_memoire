Rails.application.routes.draw do
<<<<<<< HEAD
  root "tops#index"

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

  # Defines the root path route ("/")
  post '/callback', to: 'linebot#callback'

=======
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
>>>>>>> 0348fbfde0827f1a432af27f62fe22ff6c4c7113
end
