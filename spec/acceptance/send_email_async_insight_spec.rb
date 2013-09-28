require "acceptance_spec_helper"

feature "Send email asynchronously insight" do
  let(:user) { User.make! }
  let(:app) { App.make!(user: user) }
  let(:source) { Source.make!(app: app) }
  let(:request) { Request.make!(source: source) }
  let!(:mailer_event) { MailerEvent.make!(request: request) }

  background do
    sign_in_as(user)
  end

  scenario "Viewing a source that recently sent an email in a request" do
    visit app_source_path(source.app, source)

    expect_to_see "Looks like you're sending emails in your requests"
  end

  scenario "Viewing the request that sent an email" do
    visit app_request_path(request.app, request)

    expect_to_see "Send FooMailer asynchronously"
  end
end
