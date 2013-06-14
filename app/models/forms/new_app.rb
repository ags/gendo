module Forms
  class NewApp < Base
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
      @app = create_app
      true
    end

    private

    def create_app
      @user.apps.create!(name: name)
    end
  end
end
