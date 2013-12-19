shared_examples_for "has access tokens" do |access_token_class|
  describe "#current_access_token" do
    it "returns the associated #{access_token_class} currently in-use" do
      token = access_token_class.make!
      model = token.__send__(described_class.name.downcase)

      expect(model.current_access_token).to eq(token)
    end
  end

  describe ".with_access_token!" do
    it "returns the #{described_class} associated with the given access token" do
      token = access_token_class.make!(token: "mah-token")

      expect(described_class.with_access_token!("mah-token")).to \
        eq(token.__send__(described_class.name.downcase))
    end

    context "no such #{described_class} exists" do
      it "raises ActiveRecord::RecordNotFound" do
        expect do
          described_class.with_access_token!("wat")
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
