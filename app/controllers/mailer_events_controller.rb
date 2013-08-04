class MailerEventsController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated_as_app_user!

  def show
    @mailer_event = app.mailer_events.find(params[:id]).decorate
  end
end
