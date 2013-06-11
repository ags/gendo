class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.valid?
      @user.save!
      auto_login(@user)
      redirect_to root_url
    else
      render :new
    end
  end
end
