class AppAccess
  def self.permitted?(app, user)
    app.user == user
  end
end
