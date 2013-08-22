require "spec_helper"

describe ApiV1::RequestsController do
  let(:params) { {request: create_request_payload_hash} }

  describe "#create" do
    context "when authenticated" do
      include_context "App authentication"

      let(:create!) { ->{ post :create, params } }

      it "queues a ProcessRequestPayloadWorker" do
        expect(create!).to change {
          ProcessRequestPayloadWorker.jobs.size
        }.by(1)
      end
    end
  end

  context "when unauthenticated" do
    let(:action!) { post :create }

    it_behaves_like "an api request requiring authentication"
  end
end
