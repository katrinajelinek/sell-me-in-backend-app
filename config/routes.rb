Rails.application.routes.draw do
  namespace :api do
    # users
    post "/users" => "users#create"

    # login
    post "/sessions" => "sessions#create"
  end
end
