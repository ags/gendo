require "spec_helper"

describe ApiV1::TransactionsController do
  let(:params) { {
    transaction: {
      controller:   'PostsController',
      action:       'new',
      path:         '/posts/new',
      format:       '*/*',
      method:       'GET',
      status:       200,
      started_at:   1370939786.0706801,
      ended_at:     1370939787.0706801,
      db_runtime:   0.1234,
      view_runtime: 0.4567,
      duration:     1.98,
      sql_events: [
        {
          sql: "SELECT * FROM users WHERE id = '1'",
          started_at:   1370939786.0706801,
          ended_at:     1370939787.0706801,
          duration:     0.321,
        }
      ],
      view_events: [
        {
          identifier:   '/foo/bar.html.erb',
          started_at:   1370939786.0706801,
          ended_at:     1370939787.0706801,
          duration:     0.321,
        }
      ]
    }
  } }

  describe "#create" do
    context "when authenticated" do
      let(:create!) { ->{ post :create, params } }

      include_context "App authentication"

      it "creates a Transaction" do
        expect(create!).to change { app.transactions.count }.by(+1)
      end

      it "creates an SqlEvent" do
        expect(create!).to change { SqlEvent.count }.by(+1)
      end

      it "creates a ViewEvent" do
        expect(create!).to change { ViewEvent.count }.by(+1)
      end
    end
  end

  context "when unauthenticated" do
    let(:action!) { post :create }

    it_behaves_like "an api request requiring authentication"
  end
end
