require "spec_helper"

describe AppsController do
  describe "#new" do
    let(:action!) { get :new }

    it_behaves_like "an action requiring sign in"
  end

  describe "#show" do
    let(:action!) { get :show, id: app.to_param }
    let(:app) { App.make! }

    it_behaves_like "an action requiring authentication as the App's User" do
      let(:action!) { get :show, id: 1 }
    end

    context "authenticated as the app user" do
      before do
        controller.authenticator.sign_in(app.user)
      end

      context "when the app has data" do
        before do
          Source.make!(app: app)
        end

        it "should render the app overview" do
          action!

          expect(response).to render_template("overview")
        end
      end

      context "when the app has no data" do
        it "should render app setup instructions" do
          action!

          expect(response).to render_template("setup_instructions")
        end
      end
    end
  end

  describe "#settings" do
    it_behaves_like "an action requiring authentication as the App's User" do
      let(:action!) { get :settings, app_id: 1 }
    end
  end
end
