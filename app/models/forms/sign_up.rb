module Forms
  class SignUp < Base

    attribute :email
    attribute :password

    validates :password,
      length: {minimum: 6}

    validates :email, format: {
      with: %r{\A.+@.+\..+\z}, # ___@___.___
      message: "doesn't look right"
    }

    validate :email_available?

    attr_reader :user

    def save!
      return false unless valid?

      @user = User.transaction do
        User.create!(email: email, password: password).tap do |user|
          UserAccessToken.generate(user).save!
        end
      end

      true
    end

    private

    def email_available?
      if User.with_email!(email).present?
        errors.add(:email, "is already taken")
      end
    rescue ActiveRecord::RecordNotFound
    end

  end
end
