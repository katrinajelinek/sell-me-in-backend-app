class Api::UsersController < ApplicationController
  before_action :authenticate_user, except: [:show, :create]

  def show
    @user = User.find(params[:id])
    render "show.json.jb"
  end

  def create
    @user = User.new(
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
    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.username = params[:username] || @user.username
      @user.first_name = params[:first_name] || @user.first_name
      @user.last_name = params[:last_name] || @user.last_name
      @user.email = params[:email] || @user.email
      if params[:password]
        if @user.authenticate(params[:old_password])
          @user.update!(
            password: params[:password],
            password_confirmation: params[:password_confirmation],
          )
        end
      end
      @user.image_url = params[:image_url] || @user.image_url
      @user.disclaimer_agreement = params[:disclaimer_agreement] || @user.disclaimer_agreement
      @user.terms_and_conditions_agreement = params[:terms_and_conditions_agreement] || @user.terms_and_conditions_agreement
    else
      render json: {}, status: :forbidden
    end

    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user
      user.destroy
      render json: { message: "Your account has been successfully deleted" }
    else
      render json: {}, status: :forbidden
    end
  end
end
