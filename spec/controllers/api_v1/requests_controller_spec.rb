require "spec_helper"

describe ApiV1::RequestsController do
  let(:params) { {request: create_request_payload_hash} }

  describe "#create" do
    let(:action!) { post :create, params }

    context "when authenticated" do
      include_context "App authentication"

      it "responds with 201 Created" do
        action!

        expect(response.status).to eq(201)
      end

      it "queues a ProcessRequestPayloadWorker" do
        expect do
          action!
        end.to change { ProcessRequestPayloadWorker.jobs.size }.by(+1)
      end
    end

    context "when unauthenticated" do
      it_behaves_like "an api request requiring authentication"
    end
  end
end
