class MessageMailer < ApplicationMailer
  default from: "sellmeinmailer@gmail.com"

  def message_email()
    @user = params[:user]
    # @seller = params[:seller]
    # @message = params[:message]
    mail(to: @user.email, subject: "Someone wants to buy your item!")
  end
end
