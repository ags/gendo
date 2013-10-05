module UrlHasApp
  def app
    @_app ||= App.from_param!(params[:app_id] || params[:id])
  end

  def assert_authenticated_as_app_user!
    unless AppAccess.permitted?(app, current_user)
      render_unauthorized
    end
  end
end
