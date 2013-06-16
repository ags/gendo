require "spec_helper"

describe SourcesController do
  describe "#show" do
    let(:app) { App.make! }
    let(:transaction) { Transaction.make!(app: app) }
    let(:action!) { get :show, app_id: app.to_param, id: transaction.source }

    it_behaves_like "an action requiring authentication as the App's User"
  end
end
