Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  post "/login", to: "users#login"
  get "/auto-login", to: "users#auto_login"

  resource :users, only: [:create]

  resources :bouldering_workouts do
    resources :boulder_problems, path: 'problems'
  end

  resources :climbing_workouts do
    resources :climbing_routes, path: 'routes'
  end

  resources :hangboard_workouts do
  end

  resources :boulder_problems
  resources :climbing_routes

end
