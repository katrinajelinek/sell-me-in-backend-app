Rails.application.routes.draw do
  namespace :api do
    # users
    get "/users/:id" => "users#show"
    post "/users" => "users#create"
    patch "/users/:id" => "users#update"
    delete "/users/:id" => "users#destroy"

    # login
    post "/sessions" => "sessions#create"

    # posts
    resources :posts

    # images
    post "/images" => "images#create"
    delete "/images/:id" => "images#destroy"

    # categories
    get "/categories" => "categories#index"
  end
end
