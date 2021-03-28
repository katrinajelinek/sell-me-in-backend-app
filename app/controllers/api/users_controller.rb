class Api::UsersController < ApplicationController
  def create
    user = User.new(
      username: params[:username],
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      image_url: params[:image_url],
      disclaimer_agreement: params[:disclaimer_agreement],
      terms_and_conditions_agreement: params[:terms_and_conditions_agreement],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
end
