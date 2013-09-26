class BulkInsertablesController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @bulk_insertable = app.bulk_insertables.find(params[:id]).decorate
  end
end
