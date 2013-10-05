class UsersController < ApplicationController
  include UrlHasUser

  before_action :assert_authenticated!
  before_action :assert_authenticated_as_requested_user!

  def update
    user.update_attributes!(user_params)
    flash[:notice] = 'Updated your account.'

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :name)
  end
end
