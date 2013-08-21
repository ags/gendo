class CreatesAppForUser
  def self.create!(user, attributes={})
    App.transaction do
      user.apps.create!(attributes).tap do |app|
        AppAccessToken.generate(app).save!
      end
    end
  end
end
