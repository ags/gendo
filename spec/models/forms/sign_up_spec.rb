require "spec_helper"

describe Forms::SignUp do
  let(:session) { {} }
  let(:authenticator) { Authenticator.new(session) }
  subject(:form) { Forms::SignUp.new(authenticator, parameters) }

  context "with valid details" do
    let(:parameters) { {email: "foo@example.com", password: "foobar"} }

    it "creates a user" do
      expect(form.save!).to be_true
      expect(form.user.email).to eq("foo@example.com")
    end

    it "authenticates as the created user" do
      form.save!
      expect(session).to eq({user_id: form.user.id})
    end

    it "sends a welcome email to the created user" do
      expect do
        form.save!
      end.to change { ActionMailer::Base.deliveries.size }.by(+1)
    end
  end

  shared_examples_for "does not sign up a User" do
    it "does not create a user" do
      expect do
        form.save!
      end.to_not change { User.count }
    end

    it "does not authenticate as a user" do
      expect do
        form.save!
      end.to_not change { session }
    end

    it "does not send an email" do
      expect do
        form.save!
      end.to_not change { ActionMailer::Base.deliveries.size }
    end
  end

  context "with an invalid password" do
    context "too short" do
      let(:parameters) { {email: "foo@example.com", password: "foo"} }

      it "sets an error message" do
        expect(form.save!).to be_false
        expect(form.errors.messages).to \
          eq({password: ["is too short (minimum is 6 characters)"]})
      end

      include_examples "does not sign up a User"
    end
  end

  context "with an invalid email" do
    context "wrong format" do
      let(:parameters) { {email: "foobar", password: "foobar"} }

      it "sets an error message" do
        expect(form.save!).to be_false
        expect(form.errors.messages).to \
          eq({email: ["doesn't look right"]})
      end

      include_examples "does not sign up a User"
    end

    context "already taken" do
      let!(:user) { User.make!(email: "foo@example.com") }
      let(:parameters) { {email: "foo@example.com", password: "foobar"} }

      it "sets an error message" do
        expect(form.save!).to be_false
        expect(form.errors.messages).to \
          eq({email: ["is already taken"]})
      end

      include_examples "does not sign up a User"
    end
  end
end
