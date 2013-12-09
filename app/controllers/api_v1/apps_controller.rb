module ApiV1
  class AppsController < ApiController
    def index
      @apps = authorized_user.apps
    end
  end
end
