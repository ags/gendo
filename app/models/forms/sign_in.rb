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
    end

    private

    def checks_out?
      unless user && user.authenticate(password)
        errors.add(:email, "Incorrect email or password")
      end
    end

    def user
      User.with_email!(email)
    rescue ActiveRecord::RecordNotFound
    end
  end
end
