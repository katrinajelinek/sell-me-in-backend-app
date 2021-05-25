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
    @post_creator = User.find(params[:post_creator])
    if @message.save
      MessageMailer.with(user: @message.user, message: @message, post_creator: @post_creator).message_email.deliver_now
      render "show.json.jb"
    else
      render json: { errors: @message.errors.full_messages }, status: :bad_request
    end
  end
end
