require 'acceptance_spec_helper'

feature "counter cacheable insight" do
  let(:user) { User.make! }
  let(:app) { App.make!(user: user) }
  let(:source) { Source.make!(app: app) }
  let(:request) { Request.make!(source: source) }
  let!(:counter_cacheable) {
    CounterCacheableQuerySet.make!(
      request: request,
      culprit_association_name: "posts"
    )
  }

  background do
    sign_in_as(user)
  end

  scenario "Viewing a Source with a recent counter cacheable query set" do
    visit app_source_path(source.app, source)

    expect_to_see "querying posts"
    expect_to_see "counter cache column"
  end

  scenario "Viewing a Request with a counter cacheable query set" do
    visit app_request_path(request.app, request)

    expect_to_see "counter cache column"
    expect_to_see "queries on posts"
  end
end
