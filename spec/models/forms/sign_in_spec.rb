require 'spec_helper'

describe Forms::SignIn do
  let!(:user) { User.make!(email: "foo@example.com", password: "foobar") }
  let(:session) { {} }
  let(:authenticator) { Authenticator.new(session) }
  subject(:form) { Forms::SignIn.new(authenticator, parameters) }

  context "with valid credentials" do
    let(:parameters) { {email: "foo@example.com", password: "foobar"} }

    it "authenticates as the matching user" do
      expect(form.save!).to be_true
      expect(session).to eq({user_id: user.id})
    end
  end

  shared_examples_for "it does not authenticate" do
    it "does not authenticate" do
      expect(form.save!).to be_false
      expect(session).to eq({})
    end

    it "sets a non field specific error" do
      form.save!
      expect(form.errors.messages).to \
        eq({email: ["Incorrect email or password"]})
    end
  end

  context "with an invalid password" do
    let(:parameters) { {email: "foo@example.com", password: "asd"} }

    include_examples "it does not authenticate"
  end

  context "with an invalid email" do
    let(:parameters) { {email: "bar.com", password: "foobar"} }

    include_examples "it does not authenticate"
  end
end
