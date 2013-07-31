require "spec_helper"
require "sidekiq/testing"

describe ApiV1::TransactionsController do
  let(:params) { {transaction: transaction_payload_hash} }

  describe "#create" do
    context "when authenticated" do
      let(:create!) { ->{ post :create, params } }

      include_context "App authentication"

      it "queues a ProcessTransactionPayloadWorker" do
        expect(create!).to change {
          ProcessTransactionPayloadWorker.jobs.size
        }.by(1)
      end
    end
  end

  context "when unauthenticated" do
    let(:action!) { post :create }

    it_behaves_like "an api request requiring authentication"
  end
end
