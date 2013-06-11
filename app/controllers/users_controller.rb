class UsersController < ApplicationController
  def new
    @form = Forms::SignUp.new
  end

  def create
    @form = Forms::SignUp.new(sign_up_params)
    if @form.valid?
      @form.save!
      auto_login(@form.user)
      redirect_to root_url
    else
      render :new
    end
  end

  def sign_up_params
    params.require(:forms_sign_up).permit(:email, :password)
  end
end
