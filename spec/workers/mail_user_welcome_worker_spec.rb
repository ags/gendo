require "sidekiq"
require_relative "../../app/workers/mail_user_welcome_worker"

class User; end
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

      expect(User).to \
        receive(:find).
        with(123).
        and_return(user)

      expect(UserWelcomeMailer).to \
        receive(:welcome).
        with(user).
        and_return(mailer)

      expect(mailer).to receive(:deliver)

      MailUserWelcomeWorker.new.perform(123)
    end
  end
end
