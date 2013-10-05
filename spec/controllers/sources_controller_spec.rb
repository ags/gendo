require "spec_helper"

describe SourcesController do
  describe "GET #show" do
    it_behaves_like "an action requiring authentication as the App's User" do
      let(:action!) { get :show, app_id: 1, id: 2 }
    end
  end
end
