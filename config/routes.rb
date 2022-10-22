Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/pages/profile", to: "pages#profile"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :events do
    resources :tickets
  end
end
