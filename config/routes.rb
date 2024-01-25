Rails.application.routes.draw do
  root "tops#index"

  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks",
  sessions: "sessions"
}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_use', to: 'tops#terms_of_use'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
