module UrlHasApp
  def app
    @_app ||= App.from_param(params[:app_id] || params[:id])
  end
end
