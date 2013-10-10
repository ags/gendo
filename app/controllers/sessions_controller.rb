class SessionsController < ApplicationController
  def destroy
    authenticator.sign_out
    redirect_to root_url
  end
end
