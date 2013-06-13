class UsersController < ApplicationController
  def new
  end

  def create
    if form.valid?
      form.save!
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def form
    @_form ||= Forms::SignUp.new(authenticator, sign_up_params)
  end
  helper_method :form

  def sign_up_params
    params.fetch(:forms_sign_up, {}).permit(:email, :password)
  end
end
