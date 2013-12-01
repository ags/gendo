require 'spec_helper'

describe CreatesUser do
  let(:creator) { CreatesUser.new(email: "shinji@nerv.org", password: "hunter2") }

  it "creates a user with the given details" do
    user = creator.create_with_access_token

    expect(user.email).to eq("shinji@nerv.org")
  end

  it "creates an access token for the created user" do
    user = creator.create_with_access_token

    expect(user.current_access_token).to be_present
  end
end
