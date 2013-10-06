require 'acceptance_spec_helper'

feature "App overview page" do
  let(:user) { User.make! }
  let!(:app) { App.make!(:with_access_token, user: user) }

  background do
    sign_in_as(user)
  end

  context "with no recorded requests" do
    scenario "provides instructions on integrating shinji" do
      visit app_path(app)

      expect_to_see "shinji gem"
      expect_to_see app.current_access_token.token
    end
  end

  context "with recorded requests" do
    scenario "provides a list of request sources" do
      source  = Source.make!(app: app)
      request = Request.make!(source: source)

      visit app_path(app)

      expect_to_see request.source.name
    end
  end
end
