class Api::UsersController < ApplicationController
  before_action :authenticate_user, except: [:show, :create]

  def show
    @user = User.find(params[:id])
    render "show.json.jb"
  end

  def create
    if params[:image]
      response = Cloudinary::Uploader.upload(params[:image], resource_type: :auto)
      cloudinary_url = response["secure_url"]
    else
      cloudinary_url = "https://res.cloudinary.com/djka3ehcg/image/upload/v1647957092/p8yxiyln4gdhr2ddtkyx.png"
    end
    @user = User.new(
      username: params[:username],
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      location: params[:location],
      image_url: cloudinary_url,
      disclaimer_agreement: params[:disclaimer_agreement],
      terms_and_conditions_agreement: params[:terms_and_conditions_agreement],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
    )
    if @user.save
      #trigger welcome email
      UserMailer.with(user: @user).welcome_email.deliver_now
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if params[:image]
      response = Cloudinary::Uploader.upload(params[:image], resource_type: :auto)
      cloudinary_url = response["secure_url"]
    end
    @user = User.find(params[:id])
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
    @user.location = params[:location] || @user.location
    @user.image_url = cloudinary_url || @user.image_url
    @user.disclaimer_agreement = params[:disclaimer_agreement] || @user.disclaimer_agreement
    @user.terms_and_conditions_agreement = params[:terms_and_conditions_agreement] || @user.terms_and_conditions_agreement

    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "Your account has been successfully deleted" }
  end
end
