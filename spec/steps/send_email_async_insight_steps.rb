step "I have an app that sent an email in a request" do
  @app = App.make!(user: @user)
  @source = Source.make!(app: @app)
  @request = Request.make!(:with_zero_runtime, source: @source)
  MailerEvent.make!(request: @request)
end

step "I view the the source of the request that sent the email" do
  visit app_source_path(@source.app, @source)
end

step "I view the request that sent an email" do
  visit app_request_path(@request.app, @request)
end
