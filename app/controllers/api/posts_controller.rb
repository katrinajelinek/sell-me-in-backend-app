class Api::PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @posts = Post.all
    render "index.json.jb"
  end

  def show
    @post = Post.find(params[:id])
    render "show.json.jb"
  end

  def create
    # if params[:video]
    #   response = Cloudinary::Uploader.upload(params[:video], resource_type: :auto)
    #   cloudinary_url = response["secure_url"]
    # end
    @post = Post.new(
      user_id: current_user.id,
      title: params[:title],
      description: params[:description],
      video_url: params[:video],
      price: params[:price],
      location: params[:location],
    )
    if @post.save
      if params[:category_ids]
        #remove eval on frontend build
        eval(params[:category_ids]).each do |category_id|
          PostCategory.create(post_id: @post.id, category_id: category_id)
        end
      end
      if params[:image_urls]
        #remove eval on frontend build
        eval(params[:image_urls]).each do |image_url|
          Image.create(post_id: @post.id, image_url: image_url)
        end
      end
      render "show.json.jb"
    else
      render json: { errors: @post.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if params[:video]
      response = Cloudinary::Uploader.upload(params[:video], resource_type: :auto)
      cloudinary_url = response["secure_url"]
    end
    @post = Post.find(params[:id])
    @post.title = params[:title] || @post.title
    @post.description = params[:description] || @post.description
    @post.video_url = cloudinary_url || @post.video_url
    @post.price = params[:price] || @post.price
    @post.location = params[:location] || @post.location
    @post.bought = params[:bought] || @post.bought
    if @post.save
      if params[:category_ids]
        @post.post_categories.destroy_all
        eval(params[:category_ids]).each do |category_id|
          PostCategory.create(post_id: @post.id, category_id: category_id)
        end
      end
      if params[:image_urls]
        eval(params[:image_urls]).each do |image_url|
          Image.create(post_id: @post.id, image_url: image_url)
        end
      end
      render "show.json.jb"
    else
      render json: { errors: @post.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: { message: "Your post has been deleted" }
  end
end
