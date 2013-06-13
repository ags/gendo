class SessionsController < ApplicationController
  def new
  end

  def create
    if sign_in_form.save!
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def sign_in_form
    @_sign_in_form ||= Forms::SignIn.new(authenticator, sign_in_params)
  end
  helper_method :sign_in_form

  def sign_in_params
    params.fetch(:forms_sign_in, {}).permit(:email, :password)
  end
end
