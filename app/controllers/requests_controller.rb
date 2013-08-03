class RequestsController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @request = app.requests.find(params[:id]).decorate
  end
end
