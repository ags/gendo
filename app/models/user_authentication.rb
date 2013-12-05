class UserAuthentication < Struct.new(:user)
  def access_token
    user.current_access_token.token
  end

  def valid?
    true
  end
end
