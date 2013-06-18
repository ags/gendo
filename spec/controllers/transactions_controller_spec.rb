require "spec_helper"

describe TransactionsController do
  describe "#show" do
    let(:action!) {
      get :show,
        app_id: app.to_param,
        source_id: source.to_param,
        id: transaction.id
    }
    let(:transaction) { Transaction.make!(source: source) }
    let(:source) { Source.make!(app: app) }
    let(:app) { App.make! }

    it_behaves_like "an action requiring authentication as the App's User"
  end
end
