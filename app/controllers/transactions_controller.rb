class TransactionsController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @transaction = app.transactions.find(params[:id]).decorate
  end
end
