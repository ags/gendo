class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  delegate :logged_in?, to: :authenticator
  helper_method :logged_in?

  delegate :current_user, to: :authenticator
  helper_method :current_user

  def assert_authenticated!
    unless logged_in?
      return render status: :unauthorized
    end
  end

  def assert_authenticated_as_app_user!
    unless logged_in? && app.user.id == current_user.id
      return render status: :unauthorized
    end
  end

  def authenticator
    @_authenticator ||= Authenticator.new(session)
  end
end
