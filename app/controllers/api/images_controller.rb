class Api::ImagesController < ApplicationController
  before_action :authenticate_user

  def create
    if params[:image]
      response = Cloudinary::Uploader.upload(params[:image], resource_type: :auto)
      cloudinary_url = response["secure_url"]
    end
    @image = Image.new(
      post_id: params[:post_id],
      image_url: cloudinary_url,
    )
    if @image.save
      render "show.json.jb"
    else
      render json: { errors: @image.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    render json: { message: "Image destroyed" }
  end
end
