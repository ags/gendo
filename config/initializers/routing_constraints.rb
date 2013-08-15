class LoggedInConstraint
  def matches?(request)
    Authenticator.new(request.session).logged_in?
  end
end
