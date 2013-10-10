class CounterCacheableQuerySetsController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    render locals: {
      counter_cacheable_query_set: query_set.decorate,
    }
  end

  private

  def query_set
    app.counter_cacheable_query_sets.find(params[:id])
  end
end
