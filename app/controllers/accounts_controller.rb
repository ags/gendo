class AccountsController < ApplicationController
  before_action :assert_authenticated!

  def settings
    render locals: {user: current_user}
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = 'Updated your account.'

      redirect_to settings_account_path
    else
      render :settings, locals: {user: current_user}
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :name)
  end
end
