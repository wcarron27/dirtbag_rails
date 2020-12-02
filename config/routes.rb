Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  resource :users, only: [:create]
  resources :bouldering_workouts
  resources :climbing_workouts
  resources :hangboard_workouts

  post "/login", to: "users#login"
  get "/auto-login", to: "users#auto_login"
end
