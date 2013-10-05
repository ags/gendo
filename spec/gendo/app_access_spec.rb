require_relative "../../app/gendo/app_access"

describe AppAccess do
  describe ".permitted?" do
    context "when the given user is the app owner" do
      it "is true" do
        user = double(:user)
        app = instance_double("App", user: user)

        expect(AppAccess.permitted?(app, user)).to eq(true)
      end

      context "when the given user is not the app owner" do
        it "is false" do
          user = double(:user)
          app = instance_double("App", user: double(:another_user))

          expect(AppAccess.permitted?(app, user)).to eq(false)
        end
      end

      context "when the given user is nil" do
        it "is false" do
          user = nil
          app = instance_double("App", user: double(:another_user))

          expect(AppAccess.permitted?(app, user)).to eq(false)
        end
      end
    end
  end
end
