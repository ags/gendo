class UsersController < ApplicationController
  before_action :assert_authenticated!
  before_action :assert_authenticated_as_request_user!

  def update
    user.update_attributes!(user_params)
    flash[:notice] = 'Updated your account.'

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def user
    @_user || User.from_param!(params[:user_id] || params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :name)
  end

  def assert_authenticated_as_request_user!
    unless user == current_user
      render_not_found
    end
  end
end
