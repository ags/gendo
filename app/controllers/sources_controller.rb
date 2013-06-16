class SourcesController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @source = Source.new(app, params[:id])
  end
end