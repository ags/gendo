class CreatesAppForUser
  def self.create!(user, attributes={})
    App.transaction do
      app = user.apps.create!(attributes)

      AppAccessToken.generate(app).save!

      app
    end
  end
end
