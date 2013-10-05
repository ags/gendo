class SourcesController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @source = app.sources.from_param!(params[:id]).decorate
  end
end
