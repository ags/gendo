class MailUserWelcomeWorker
  include Sidekiq::Worker

  def self.welcome(user)
    perform_async(user.id)
  end

  def perform(user_id)
    user = User.find(user_id)

    UserWelcomeMailer.welcome(user).deliver
  end
end
