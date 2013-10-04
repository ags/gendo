require_relative "../../../lib/form/model"
require_relative "../../../app/models/form/github_sign_in"

describe Form::GithubSignIn do
  let(:github_user) { class_double("GithubUser").as_stubbed_const }
  let(:authenticator) { instance_double("Authenticator") }
  let(:mailer) { class_double("MailUserWelcomeWorker").as_stubbed_const }

  let(:github_access_token) { double(:github_access_token) }

  subject(:form) {
    Form::GithubSignIn.new(
      authenticator,
      github_access_token: github_access_token
    )
  }

  before do
    allow(mailer).to \
      receive(:welcome)

    allow(authenticator).to \
      receive(:sign_in)

    expect(github_user).to \
      receive(:find_or_initialize).
      with(github_access_token).
      and_return(user)
  end

  shared_examples_for "saves the user" do
    it "saves the user" do
      expect(user).to \
        receive(:save!)

      expect(form.save!).to eq(true)
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
      expect(mailer).to_not \
        receive(:welcome)

      form.save!
    end
  end
end
