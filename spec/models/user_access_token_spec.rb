require 'spec_helper'

describe UserAccessToken do
  it_behaves_like "an access token" do
    let(:model) { User.new }
  end
end
