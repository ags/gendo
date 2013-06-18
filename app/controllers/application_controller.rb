class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  delegate :logged_in?, to: :authenticator
  helper_method :logged_in?

  delegate :current_user, to: :authenticator
  helper_method :current_user

  def assert_authenticated!
    render_unauthorized unless logged_in?
  end

  def assert_authenticated_as_app_user!
    unless logged_in? && app.user.id == current_user.id
      render_unauthorized
    end
  end

  def authenticator
    @_authenticator ||= Authenticator.new(session)
  end

  private

  def render_unauthorized
    return render "/statics/unauthorized", status: :unauthorized
  end

end
