class Api::MessagesController < ApplicationController
  before_action :authenticate_user

  def show
    @message = Message.find(params[:id])
    render "show.json.jb"
  end

  def create
    @message = Message.new(
      user_id: current_user.id,
      message: params[:message],
    )
    if @message.save
      render "show.json.jb"
    else
      render json: { errors: @message.errors.full_messages }, status: :bad_request
    end
  end
end
