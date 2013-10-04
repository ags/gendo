module Form
  class GithubSignIn
    include Form::Model

    attribute :github_access_token

    attr_reader :user

    def initialize(authenticator, *args)
      super(*args)
      @authenticator = authenticator
    end

    def save!
      @user = GithubUser.find_or_initialize(github_access_token)

      send_welcome_email = @user.new_record?

      @user.save!

      if send_welcome_email
        MailUserWelcomeWorker.welcome(@user)
      end

      @authenticator.sign_in(@user)

      true
    end
  end
end
