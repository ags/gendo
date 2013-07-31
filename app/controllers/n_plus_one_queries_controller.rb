class NPlusOneQueriesController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @n_plus_one_query = app.n_plus_one_queries.find(params[:id]).decorate
  end
end
