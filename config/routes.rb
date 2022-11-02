Rails.application.routes.draw do
  get 'pdf/show'
  #ROUTES FOR USERS
  devise_for :users
  root to: "pages#home"
  get "/pages/profile", to: "pages#profile"
  get "/search", to: "events#search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #ROUTES FOR EVENTS
  resources :events do
   # resources :tickets
    resources :orders, only: [:new, :create, :update]
  end

  resources :orders, only: [:index, :show]
  resources :tickets, only: [:index]
end
