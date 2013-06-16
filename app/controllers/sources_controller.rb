class SourcesController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @source = params[:id]
    @transactions = app.transactions_with_source(params[:id])
  end
end
