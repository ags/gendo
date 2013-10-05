require "spec_helper"

describe RequestsController do
  describe "#show" do
    it_behaves_like "an action requiring authentication as the App's User" do
      let(:action!) { get :show, app_id: 1, source_id: 2, id: 3 }
    end
  end
end
