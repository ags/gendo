module Forms
  class SignUp < Base
    attribute :email
    attribute :password

    validates :password,
      length: {minimum: User::MINIMUM_PASSWORD_LENGTH}

    validates :email, format: {
      with: Formats::EMAIL,
      message: "doesn't look right"
    }

    validate :email_available?

    attr_reader :user

    def initialize(authenticator, *args)
      super(*args)
      @authenticator = authenticator
    end

    def save!
      return false unless valid?

      @user = create_user

      @authenticator.sign_in(user)

      queue_welcome_email

      true
    end

    private

    def create_user
      User.create!(email: email, password: password)
    end

    def queue_welcome_email
      MailUserWelcomeWorker.welcome(user)
    end

    def email_available?
      unless User.email_available?(email)
        errors.add(:email, "is already taken")
      end
    end
  end
end
