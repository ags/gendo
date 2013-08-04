require "spec_helper"

describe NPlusOneQueriesController do
  describe "GET #show" do
    let(:action!) {
      get :show,
        app_id: request.app.to_param,
        request_id: request.to_param,
        id: n_plus_one_query.to_param
    }
    let(:n_plus_one_query) { NPlusOneQuery.make!(request: request) }
    let(:request) { Request.make!(source: source) }
    let(:source) { Source.make!(app: app) }
    let(:app) { App.make! }

    it_behaves_like "an action requiring authentication as the App's User"
  end
end
