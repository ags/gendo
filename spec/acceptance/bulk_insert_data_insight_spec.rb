require "acceptance_spec_helper"

feature "bulk insert data insight" do
  let(:user) { User.make! }
  let(:app) { App.make!(user: user) }
  let(:source) { Source.make!(app: app) }
  let(:request) { Request.make!(source: source) }
  let!(:bulk_insertable) { BulkInsertable.make!(request: request) }

  background do
    sign_in_as(user)
  end

  scenario "Viewing a Source with a recent bulk insertable" do
    visit app_source_path(source.app, source)

    expect_to_see "single bulk insert statement"
  end

  scenario "Viewing a Request with a bulk insertable" do
    visit app_request_path(request.app, request)

    expect_to_see "Bulk insert data"
  end

  scenario "Viewing the bulk insert data insight" do
    visit app_bulk_insertable_path(bulk_insertable.app, bulk_insertable)

    expect_to_see "combine these into a single bulk insert"
  end
end
