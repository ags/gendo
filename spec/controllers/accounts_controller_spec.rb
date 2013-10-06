require 'spec_helper'

describe AccountsController do
  describe "GET #settings" do
    let(:action!) { get :settings }

    it_behaves_like "an action requiring sign in"
  end

  describe "PATCH #update" do
    let(:user) { instance_double("User") }
    subject(:action!) { patch :update, user: {email: "shinji@nerv.org"} }

    context "when signed in" do
      before do
        allow(controller).to \
          receive(:logged_in?).
          and_return(true)

        allow(controller).to \
          receive(:current_user).
          and_return(user)
      end

      it "updates the signed in user" do
        expect(user).to \
          receive(:update_attributes).
          with("email" => "shinji@nerv.org").
          and_return(true)

        action!
      end

      it "redirects to the account settings page" do
        allow(user).to \
          receive(:update_attributes).
          and_return(true)

        action!

        expect(response).to redirect_to(settings_account_path)
      end

      context "when updating fails" do
        it "renders the settings page" do
          allow(user).to \
            receive(:update_attributes).
            and_return(false)

          action!

          expect(response).to render_template("settings")
        end
      end
    end

    context "when not signed in" do
      it "responds with 401 Unauthorized" do
        expect(controller).to \
          receive(:logged_in?).
          and_return(false)

        action!

        expect(response.status).to eq(401)
      end
    end
  end
end
