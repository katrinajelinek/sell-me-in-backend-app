class MessageMailer < ApplicationMailer
  default from: "sellmeinmailer@gmail.com"

  def message_email()
    @user = params[:user]
    @post_creator = params[:post_creator]
    @message = params[:message]
    mail(to: @post_creator.email, subject: "Someone wants to buy from you!")
  end
end
