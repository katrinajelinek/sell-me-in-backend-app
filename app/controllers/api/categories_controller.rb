class Api::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render "index.json.jb"
  end

  def show
    @category = Category.find(params[:id])
    render "show.json.jb"
  end
end
