module ApiV1
  class ApiController < ActionController::Base
    respond_to :json

    include ErrorHandlers

    include Authentication
  end
end
