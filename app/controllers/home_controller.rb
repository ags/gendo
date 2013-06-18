class HomeController < ApplicationController
  def index
    return redirect_to apps_path if logged_in?
  end
end
