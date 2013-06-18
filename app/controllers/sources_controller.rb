class SourcesController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @source = Source.from_param!(params[:id])
  end
end
