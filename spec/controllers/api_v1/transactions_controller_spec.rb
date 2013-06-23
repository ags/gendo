require "spec_helper"

describe ApiV1::TransactionsController do
  let(:params) { {
    transaction: {
      path:           '/posts/new',
      status:         200,
      started_at:     1370939786.0706801,
      ended_at:       1370939787.0706801,
      db_runtime:     0.1234,
      view_runtime:   0.4567,
      duration:       1.98,
      shinji_version: "0.0.1",
      framework:      "Rails 5.0.0",
      source: {
        controller:   'PostsController',
        action:       'new',
        format_type:  '*/*',
        method_name:  'GET',
      },
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
      ],
      mailer_events: [
        {
          mailer:     "FooMailer",
          message_id: "4f5b5491f1774_181b23fc3d4434d38138e5@mba.local.mail",
          started_at: 1370939788.0706801,
          ended_at:   1370939789.0706801,
          duration:   0.321,
        }
      ]
    }
  } }

  describe "#create" do
    context "when authenticated" do
      let(:create!) { ->{ post :create, params } }

      include_context "App authentication"

      it "creates a Transaction" do
        expect(create!).to change { Transaction.count }.by(+1)
      end

      it "creates a Source" do
        expect(create!).to change { app.sources.count }.by(+1)
      end

      it "creates an SqlEvent" do
        expect(create!).to change { SqlEvent.count }.by(+1)
      end

      it "creates a ViewEvent" do
        expect(create!).to change { ViewEvent.count }.by(+1)
      end

      it "creates a MailerEvent" do
        expect(create!).to change { MailerEvent.count }.by(+1)
      end
    end
  end

  context "when unauthenticated" do
    let(:action!) { post :create }

    it_behaves_like "an api request requiring authentication"
  end
end
