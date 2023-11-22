Rails.application.routes.draw do
<<<<<<< HEAD
<<<<<<< HEAD
  root "tops#index"
=======
<<<<<<< HEAD
  root 'tops#index'

>>>>>>> adcbcae (Revert "Flash massages")
  devise_for :users, controllers: {
  omniauth_callbacks: "omniauth_callbacks",
  sessions: "sessions"
}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

<<<<<<< HEAD
=======
  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_use', to: 'tops#terms_of_use'
=======
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
>>>>>>> 9108fe7 (Revert "Flash massages")
>>>>>>> adcbcae (Revert "Flash massages")
=======
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
>>>>>>> 9108fe7 (Revert "Flash massages")
end
