require 'spec_helper'

describe AppAccessToken do
  it_behaves_like "an access token" do
    let(:model) { App.new }
  end
end
