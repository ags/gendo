require_relative "../../../app/models/forms/base"
require_relative "../../../app/models/forms/github_sign_in"
# Required due to odd behaviour with re-opening empty class.
require_relative "../../../app/models/github_user"

class MailUserWelcomeWorker; end

describe Forms::GithubSignIn do
  let(:github_access_token) { "github-access-token" }
  let(:authenticator) { double(:authenticator).as_null_object }

  subject(:form) {
    Forms::GithubSignIn.new(
      authenticator,
      github_access_token: github_access_token
    )
  }

  before do
    allow(MailUserWelcomeWorker).to receive(:welcome)

    expect(GithubUser).to \
      receive(:find_or_initialize).
      with(github_access_token).
      and_return(user)
  end

  shared_examples_for "saves the user" do
    it "saves the user" do
      expect(user).to \
        receive(:save!)

      expect(form.save!).to be_true
    end
  end

  shared_examples_for "signs in as the user" do
    it "signs in as the user" do
      expect(authenticator).to \
        receive(:sign_in).
        with(user)

      form.save!
    end
  end

  context "with a new user" do
    let(:user) { double(:user, new_record?: true, save!: true) }

    include_examples "saves the user"

    include_examples "signs in as the user"

    it "queues a welcome email for the user" do
      expect(MailUserWelcomeWorker).to \
        receive(:welcome).
        with(user)

      form.save!
    end
  end

  context "with an existing user" do
    let(:user) { double(:user, new_record?: false, save!: true) }

    include_examples "saves the user"

    include_examples "signs in as the user"

    it "does not queue a welcome email" do
      expect(MailUserWelcomeWorker).to_not \
        receive(:welcome)

      form.save!
    end
  end
end
