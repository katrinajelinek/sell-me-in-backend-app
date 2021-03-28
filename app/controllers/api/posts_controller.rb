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
    @post = Post.new(
      user_id: current_user.id,
      title: params[:title],
      description: params[:description],
      video_url: params[:video_url],
      price: params[:price],
      location: params[:location],
    )
    if @post.save
      render "show.json.jb"
    else
      render json: { errors: @post.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:title] || @post.title
    @post.description = params[:description] || @post.description
    @post.video_url = params[:video_url] || @post.video_url
    @post.price = params[:price] || @post.price
    @post.location = params[:location] || @post.location
    if @post.save
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
