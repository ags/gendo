require "spec_helper"

describe CreatesAppForUser do
  describe "#create!" do
    let(:user) { User.make! }

    it "creates an App associated with the given User" do
      app = CreatesAppForUser.create!(user, name: "Shinji")

      expect(app.name).to eq("Shinji")
      expect(app.user).to eq(user)
    end

    it "creates an AppAccessToken for the created App" do
      app = CreatesAppForUser.create!(user, name: "Shinji")

      expect(app.current_access_token).to be_present
    end
  end
end
