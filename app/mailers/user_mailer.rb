class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
def welcome
  @user = params[:user] # Instance variable => available in view
  mail(to: @user.email, subject: 'Welcome to Haze')
  # This will render a view in `app/views/user_mailer`!
end

def invite
  @sender_name = params[:sender_name]
  @group_name = Group.find(params[:group_id]).name
  mail(to: params[:friend_email], subject: "Start Planning Your Trip @HAZE!")
end
end
