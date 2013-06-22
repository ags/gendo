class UserWelcomeMailer < ActionMailer::Base
  default from: "support@gendo.io"

  def welcome(user)
    @user = user

    mail to: @user.email,
         subject: "Welcome to Gendo!"
  end
end
