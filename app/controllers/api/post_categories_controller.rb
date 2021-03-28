class Api::PostCategoriesController < ApplicationController
  before_action :authenticate_user

  def create
    @post_category = PostCategory.new(
      post_id: params[:post_id],
      category_id: params[:category_id],
    )
    if @post_category.save
      render "show.json.jb"
    else
      render json: { errors: @post_category.errors.full_messages }, status: :bad_request
    end
  end
end
