module Forms
  class NewApp < Base
    attr_reader :app

    attribute :name

    validates :name,
      length: {minimum: 1}

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
