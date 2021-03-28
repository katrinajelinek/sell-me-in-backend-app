class Api::ImagesController < ApplicationController
  before_action :authenticate_user

  def create
    @image = Image.new(
      post_id: params[:post_id],
      image_url: params[:image_url],
    )
    if @image.save
      render "show.json.jb"
    else
      render json: { errors: @image.errors.full_messages }, status: :bad_request
    end
  end
end
