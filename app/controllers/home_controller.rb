class HomeController < ApplicationController
  def index
    if logged_in?
      render :authenticated_index
    else
      render :unauthenticated_index
    end
  end
end
