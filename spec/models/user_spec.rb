require "spec_helper"

describe User do
  it "requires an email address" do
    user = User.new(password: "foo")
    expect(user.valid?).to be_false
    expect(user.errors[:email]).to eq(["can't be blank"])
  end

  it "requires passwords of length 6 or more" do
    user = User.new(password: "foo")
    expect(user.valid?).to be_false
    expect(user.errors[:password]).to eq(["must be at least 6 characters long"])
  end

  it "does not permit duplicate emails" do
    User.create!(email: "foo@bar.com", password: "foobar")
    expect do
      User.create!(email: "foo@bar.com", password: 'password')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
