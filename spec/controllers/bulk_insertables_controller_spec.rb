require "spec_helper"

describe BulkInsertablesController do
  describe "GET #show" do
    it_behaves_like "an action requiring authentication as the App's User" do
      let(:action!) { get :show, app_id: 1, request_id: 2, id: 3 }
    end
  end
end
