module UrlHasUser
  def user
    @_user || User.from_param!(params[:user_id] || params[:id])
  end

  def assert_authenticated_as_requested_user!
    unless user == current_user
      render_not_found
    end
  end
end
