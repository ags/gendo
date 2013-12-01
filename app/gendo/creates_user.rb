class CreatesUser
  def initialize(opts)
    @email = opts.fetch(:email)
    @password = opts.fetch(:password)
  end

  def create_with_access_token
    User.transaction do
      user = User.create!(email: email, password: password)

      UserAccessToken.generate(user).save!

      user
    end
  end

  private

  attr_reader :email
  attr_reader :password
end
