class DevelopmentController < ApplicationController
  before_action :assert_not_production!

  def sign_in_as
    authenticator.sign_in(User.find(params[:user_id]))
    redirect_to root_url
  end

  def assert_not_production!
    raise if Rails.env.production?
  end
end
