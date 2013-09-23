class SessionsController < ApplicationController
  def destroy
    authenticator.sign_out
    redirect_to root_url
  end

  def bypass
    raise unless Rails.env.test?
    authenticator.sign_in(User.find(params[:user_id]))
    redirect_to root_url
  end
end
