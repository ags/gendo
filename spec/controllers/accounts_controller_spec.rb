require 'spec_helper'

describe AccountsController do
  describe "GET #settings" do
    let(:action!) { get :settings }

    it_behaves_like "an action requiring sign in"
  end
end
