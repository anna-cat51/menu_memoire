Rails.application.routes.draw do
  root 'tops#index'

  get "tops/create" => "tops#create"
  get "tops/show" => "tops#show"
  get "tops/assets" => "tops#assets"


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

  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_use', to: 'tops#terms_of_use'
end
