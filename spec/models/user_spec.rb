require "spec_helper"

describe User do
  describe "#from_param!" do
    it "returns the User with the given id" do
      user = User.make!

      expect(User.from_param!(user.id)).to eq(user)
    end

    context "when no User with the given id exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          User.from_param!(0)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "creation" do
    let(:email) { "shinji@nerv.com" }
    let(:password) { "hunter2" }

    it "can be created with a github user id and email" do
      user = User.create!(github_user_id: 1, email: email)

      expect(user.valid?).to eq(true)
    end

    it "can be created with an email and password" do
      user = User.create!(email: email, password: password)

      expect(user.valid?).to eq(true)
    end
  end
end
