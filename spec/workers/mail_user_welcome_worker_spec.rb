module Sidekiq; module Worker; end; end
require_relative "../../app/workers/mail_user_welcome_worker"

class UserWelcomeMailer; end

describe MailUserWelcomeWorker do
  describe ".welcome" do
    it "queues the worker with the given user's id" do
      user = double(:user, id: 123)

      expect(MailUserWelcomeWorker).to \
        receive(:perform_async).
        with(user.id)

      MailUserWelcomeWorker.welcome(user)
    end
  end

  describe "#perform" do
    it "sends a UserWelcomeMailer to the user" do
      user = double(:user)
      mailer = double(:mailer)

      expect(class_double("User").as_stubbed_const).to \
        receive(:find).
        with(123).
        and_return(user)

      # TODO class_double fails here. ActionMailer?
      expect(UserWelcomeMailer).to \
        receive(:welcome).
        with(user).
        and_return(mailer)

      expect(mailer).to receive(:deliver)

      MailUserWelcomeWorker.new.perform(123)
    end
  end
end
