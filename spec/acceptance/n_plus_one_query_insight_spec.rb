require "acceptance_spec_helper"

feature "n+1 query insight" do
  let(:user) { User.make! }
  let(:app) { App.make!(user: user) }
  let(:source) { Source.make!(app: app) }
  let(:request) { Request.make!(source: source) }
  let!(:n_plus_one_query) { NPlusOneQuery.make!(request: request) }

  background do
    sign_in_as(user)
  end

  scenario "Viewing a Source with a recent n+1 query" do
    visit app_source_path(source.app, source)

    expect_to_see "pattern of an n+1 query"
  end

  scenario "Viewing a Request with an n+1 query" do
    visit app_request_path(request.app, request)

    expect_to_see "Detected an n+1 query"
  end

  scenario "Viewing the n+1 query insight" do
    visit app_n_plus_one_query_path(n_plus_one_query.app, n_plus_one_query)

    expect_to_see "This may be an n+1 query"
  end
end
