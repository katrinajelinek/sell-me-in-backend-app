class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
    render "index.json.jb"
  end
end
