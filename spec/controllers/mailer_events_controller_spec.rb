require "spec_helper"

describe MailerEventsController do
  describe "GET #show" do
    let(:action!) {
      get :show,
        app_id: app.to_param,
        source_id: source.to_param,
        request_id: request.to_param,
        id: mailer_event.to_param
    }
    let(:mailer_event) { MailerEvent.make!(request: request) }
    let(:request) { Request.make!(source: source) }
    let(:source) { Source.make!(app: app) }
    let(:app) { App.make! }

    it_behaves_like "an action requiring authentication as the App's User"
  end
end
