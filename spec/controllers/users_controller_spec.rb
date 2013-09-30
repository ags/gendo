require 'spec_helper'

describe UsersController do
  describe "PATCH #update" do
    let(:user) { User.make! }
    subject(:action!) {
      patch :update, id: user.id, user: {email: "shinji@nerv.org"}
    }

    context "when logged in as the given user" do
      before do
        controller.authenticator.sign_in(user)
      end

      it "updates the given user" do
        expect do
          action!
          user.reload
        end.to change { user.email }.to("shinji@nerv.org")
      end
    end

    context "when logged in as a different user" do
      before do
        controller.authenticator.sign_in(User.make!)
      end

      it "responds with 404 Not Found" do
        action!

        expect(response.status).to eq(404)
      end
    end

    context "when not logged in" do
      it "responds with 401 Unauthorized" do
        action!

        expect(response.status).to eq(401)
      end
    end
  end
end
