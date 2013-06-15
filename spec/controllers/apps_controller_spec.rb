require "spec_helper"

describe AppsController do
  describe "#new" do
    let(:action!) { get :new }

    it_behaves_like "an action requiring sign in"
  end

  describe "#show" do
    let(:action!) { get :show, id: app.to_param }
    let(:app) { App.make! }

    it_behaves_like "an action requiring authentication as the App's User"
  end
end
