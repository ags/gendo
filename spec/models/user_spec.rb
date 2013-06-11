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
    expect(user.errors[:password]).to \
      eq(["is too short (minimum is 6 characters)"])
  end

  it "does not permit duplicate emails" do
    User.create!(email: "foo@bar.com", password: "foobar")
    expect do
      User.create!(email: "foo@bar.com", password: 'password')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe ".with_email!" do
    it "returns the User with the given email" do
      user = User.make!(email: "foo@bar.com")
      expect(User.with_email!("foo@bar.com")).to eq(user)
    end

    context "when no User with given email exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          User.with_email!("foo@bar.com")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#current_access_token" do
    it "returns the associated UserAccessToken currently in-use" do
      token = UserAccessToken.make!
      user = token.user
      expect(user.current_access_token).to eq(token)
    end
  end
end
