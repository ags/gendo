module ApiV1
  class AppsController < ApiController
    before_filter :assert_app_access, only: [:show]

    def index
      @apps = authorized_user.apps
    end

    def show
      @app = app
    end

    private

    def app
      @_app ||= App.from_param(params[:app_id] || params[:id])
    end

    def assert_app_access
      unless AppAccess.permitted?(app, authorized_user)
        raise ::ApiV1::NotFound
      end
    end
  end
end
