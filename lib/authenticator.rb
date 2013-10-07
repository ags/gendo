class Authenticator
  class AnonUser
    def nil?; true; end
  end

  def initialize(session)
    @session = session
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    if id = @session[:user_id]
      user_finder.call(id)
    else
      AnonUser.new
    end
  end

  def sign_in(user)
    @session[:user_id] = user.id
  end

  def sign_out
    @session.delete(:user_id)
  end

  attr_writer :user_finder

  private

  def user_finder
    @user_finder || ->(id) {
      @_user ||= User.where(id: id).first
    }
  end
end
