class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
    render "index.json.jb"
  end

  def show
    @post = Post.find(params[:id])
    render "show.json.jb"
  end
end
