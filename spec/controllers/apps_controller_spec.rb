require "spec_helper"

describe AppsController do
  describe "#new" do
    let(:action!) { get :new }

    it_behaves_like "an action requiring sign in"
  end
end
