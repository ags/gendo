require "spec_helper"

describe BulkInsertablesController do
  describe "GET #show" do
    let(:action!) {
      get :show,
        app_id: request.app.to_param,
        request_id: request.to_param,
        id: bulk_insertable.to_param
    }
    let(:bulk_insertable) { BulkInsertable.make!(request: request) }
    let(:request) { Request.make!(source: source) }
    let(:source) { Source.make!(app: app) }
    let(:app) { App.make! }

    it_behaves_like "an action requiring authentication as the App's User"
  end
end
