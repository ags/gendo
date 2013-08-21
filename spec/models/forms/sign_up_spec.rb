unless defined?(User::MINIMUM_PASSWORD_LENGTH)
  class User; MINIMUM_PASSWORD_LENGTH = 6; end
end
class MailUserWelcomeWorker; end

require_relative "../../../lib/formats"
require_relative "../../../app/models/forms/base"
require_relative "../../../app/models/forms/sign_up"

describe Forms::SignUp do
  let(:authenticator) { double(:authenticator) }
  subject(:form) { Forms::SignUp.new(authenticator, parameters) }

  context "with valid details" do
    let(:parameters) { {email: "foo@example.com", password: "foobar"} }
    let(:user) { double(:user) }
    let(:user_creator) { ->(email, password) { user } }

    before do
      form.user_creator = user_creator
      allow(User).to receive(:email_available?).and_return(true)
      allow(authenticator).to receive(:sign_in)
      allow(MailUserWelcomeWorker).to receive(:welcome)
    end

    it "creates a user" do
      form.save!

      expect(form.user).to eq(user)
    end

    it "authenticates as the created user" do
      expect(authenticator).to receive(:sign_in).with(user)

      form.save!
    end

    it "queues a welcome email to the created user" do
      expect(MailUserWelcomeWorker).to receive(:welcome).with(user)

      form.save!
    end

    it "returns true when saved" do
      expect(form.save!).to be_true
    end
  end

  shared_examples_for "does not sign up a User" do
    it "does not create a user" do
      form.save!

      expect(form.user).to be_nil
    end

    it "does not authenticate as a user" do
      expect(authenticator).to_not receive(:sign_in)

      form.save!
    end

    it "does not send an email" do
      expect(MailUserWelcomeWorker).to_not receive(:welcome)

      form.save!
    end

    it "returns false when saved" do
      expect(form.save!).to be_false
    end
  end

  context "with a password that is too short" do
    let(:parameters) { {email: "foo@example.com", password: "foo"} }

    before do
      allow(User).to receive(:email_available?).and_return(true)
    end

    it "sets an error message" do
      form.save!

      expect(form.errors.messages).to \
        eq({password: ["is too short (minimum is 6 characters)"]})
    end

    include_examples "does not sign up a User"
  end

  context "with an email in an invalid format" do
    let(:parameters) { {email: "foobar", password: "foobar"} }

    before do
      allow(User).to receive(:email_available?).and_return(true)
    end

    it "sets an error message" do
      form.save!

      expect(form.errors.messages).to \
        eq({email: ["doesn't look right"]})
    end

    include_examples "does not sign up a User"
  end

  context "with an email that's already been taken" do
    let(:parameters) { {email: "foo@example.com", password: "foobar"} }

    before do
      allow(User).to receive(:email_available?).and_return(false)
    end

    it "sets an error message" do
      form.save!

      expect(form.errors.messages).to \
        eq({email: ["is already taken"]})
    end

    include_examples "does not sign up a User"
  end
end
