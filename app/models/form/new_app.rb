module Form
  class NewApp
    include Form::Model

    attribute :name

    validates :name,
      length: {minimum: 1}

    attr_reader :app

    def initialize(user, *args)
      super(*args)
      @user = user
    end

    def save!
      return false unless valid?

      @app = CreatesAppForUser.create!(@user, name: name)

      true
    end
  end
end
