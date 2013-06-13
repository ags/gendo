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

  def destroy
    authenticator.sign_out
    redirect_to root_url
  end

  def bypass
    raise unless Rails.env.test?
    authenticator.sign_in(User.find(params[:user_id]))
    redirect_to root_url
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
