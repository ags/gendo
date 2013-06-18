class AppsController < ApplicationController
  include UrlHasApp

  before_action :assert_authenticated!, only: [:new, :create]
  before_action :assert_authenticated_as_app_user!, only: [:show]

  def new
  end

  def create
    if new_app_form.valid?
      new_app_form.save!
      redirect_to app_path(new_app_form.app)
    else
      render :new
    end
  end

  def show
    @app = app.decorate

    if @app.collecting_data?
      render :overview
    else
      render :setup_instructions
    end
  end

  private

  def new_app_form
    @_new_app_form ||= Forms::NewApp.new(current_user, new_app_params)
  end
  helper_method :new_app_form

  def new_app_params
    params.fetch(:forms_new_app, {}).permit(:name)
  end
end
