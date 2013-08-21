module Forms
  class SignUp < Base
    attr_reader :user
    attr_writer :user_creator

    attribute :email
    attribute :password

    validates :password,
      length: {minimum: User::MINIMUM_PASSWORD_LENGTH}

    validates :email, format: {
      with: Formats::EMAIL,
      message: "doesn't look right"
    }

    validate :email_available?

    def initialize(authenticator, *args)
      super(*args)
      @authenticator = authenticator
    end

    def save!
      return false unless valid?

      @user = user_creator.call(email, password)

      @authenticator.sign_in(user)

      MailUserWelcomeWorker.welcome(user)

      true
    end

    private

    def user_creator
      @user_creator || ->(email, password) {
        User.create!(email: email, password: password)
      }
    end

    def email_available?
      unless User.email_available?(email)
        errors.add(:email, "is already taken")
      end
    end
  end
end
