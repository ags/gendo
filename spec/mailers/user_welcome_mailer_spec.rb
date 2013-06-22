require "spec_helper"

describe UserWelcomeMailer do
  describe "#welcome" do
    let(:user) { User.make! }
    subject(:mail) { UserWelcomeMailer.welcome(user) }

    it "sets the receipient address to the given user's email" do
      expect(mail.to).to eq([user.email])
    end

    it "sets the sender address to Gendo support" do
      expect(mail.from).to eq(["support@gendo.io"])
    end

    it "sets the subject line" do
      expect(mail.subject).to eq("Welcome to Gendo!")
    end
  end
end
