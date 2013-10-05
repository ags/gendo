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

  def render_not_found
    return render "/statics/not_found", status: :not_found
  end
end
