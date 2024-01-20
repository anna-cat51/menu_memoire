Rails.application.routes.draw do
<<<<<<< HEAD
<<<<<<< HEAD
  root 'tops#index'
=======
  root "tops#index"
>>>>>>> 05b9eed (コンフリクト解消)

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks',
    sessions: 'sessions'
  }

  resources :repertoires do
    collection do
      post :scrape
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  post '/callback', to: 'linebot#callback'

<<<<<<< HEAD
  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_use', to: 'tops#terms_of_use'
=======
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
>>>>>>> 9108fe7 (Revert "Flash massages")
=======
>>>>>>> 05b9eed (コンフリクト解消)
end
