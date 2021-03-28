Rails.application.routes.draw do
  namespace :api do
    # users
    get "/users/:id" => "users#show"
    post "/users" => "users#create"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    # posts
    resources :posts

    # login
    post "/sessions" => "sessions#create"
  end
end
