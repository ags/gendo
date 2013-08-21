module Forms
  class SignIn < Base
    attribute :email
    attribute :password

    validate :checks_out?

    def initialize(authenticator, *args)
      super(*args)
      @authenticator = authenticator
    end

    def save!
      return false unless valid?
      @authenticator.sign_in(user)
      true
    end

    attr_writer :user_finder

    private

    def checks_out?
      unless user && user.authenticate(password)
        errors.add(:email, "Incorrect email or password")
      end
    end

    def user
      user_finder.call(email)
    end

    def user_finder
      @user_finder || ->(email) { User.with_email(email) }
    end
  end
end
