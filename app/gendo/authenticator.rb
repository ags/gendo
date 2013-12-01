class Authenticator
  attr_writer :user_finder

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate
    if user && user.authenticate(password)
      UserAuthentication.new(user)
    else
      InvalidAuthentication.new("Incorrect email or password")
    end
  end

  private

  attr_reader :email
  attr_reader :password

  def user
    @_user ||= user_finder.call
  end

  def user_finder
    @user_finder || ->{ User.with_email(email) }
  end
end
