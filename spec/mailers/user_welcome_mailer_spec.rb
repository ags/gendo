require "spec_helper"

describe UserWelcomeMailer do
  describe "#welcome" do
    let(:user) { double(:user, email: "bob@example.com") }
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

    it "contains a link to the new app page" do
      expect(mail.body).to match(/#{new_app_url}/)
    end
  end
end
