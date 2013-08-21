module Forms
  class NewApp < Base
    attr_reader :app
    attr_writer :app_creator

    attribute :name

    validates :name,
      length: {minimum: 1}

    def initialize(user, *args)
      super(*args)
      @user = user
    end

    def save!
      return false unless valid?

      @app = app_creator.call(name: name)

      true
    end

    private

    def app_creator
      @app_creator || ->(*attributes) {
        CreatesAppForUser.create!(@user, *attributes)
      }
    end
  end
end
