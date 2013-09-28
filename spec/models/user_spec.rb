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
end
