require_relative "../../../app/models/forms/base"
require_relative "../../../app/models/forms/sign_in"

class User; end

describe Forms::SignIn do
  let(:user) { double(:user) }
  let(:authenticator) { double(:authenticator) }
  subject(:form) { Forms::SignIn.new(authenticator, parameters) }

  before do
    form.user_finder = ->(email) { user }
  end

  context "with valid credentials" do
    let(:parameters) { {email: "foo@example.com", password: "foobar"} }

    it "authenticates as the matching user" do
      expect(user).to \
        receive(:authenticate).
        with(parameters[:password]).
        and_return(true)

      expect(authenticator).to receive(:sign_in).with(user)

      expect(form.save!).to be_true
    end
  end

  shared_examples_for "it does not authenticate" do
    it "does not authenticate" do
      expect(authenticator).to_not receive(:sign_in)
      expect(form.save!).to be_false
    end

    it "sets a non-field specific error" do
      form.save!

      expect(form.errors.messages).to \
        eq({email: ["Incorrect email or password"]})
    end
  end

  context "with an invalid password" do
    let(:parameters) { {email: "foo@example.com", password: "asd"} }

    before do
      expect(user).to \
        receive(:authenticate).
        with(parameters[:password]).
        and_return(false)
    end

    include_examples "it does not authenticate"
  end

  context "when no user with the given email exists" do
    let(:parameters) { {email: "bar.com", password: "foobar"} }
    let(:user) { nil }

    include_examples "it does not authenticate"
  end
end
