step "I have an app with an n+1 query" do
  @app = App.make!(user: @user)
  @source = Source.make!(app: @app)
  @request = Request.make!(:with_zero_runtime, source: @source)
  @n_plus_one_query = NPlusOneQuery.make!(request: @request)
end

step "I view the source of the n+1 query" do
  visit app_source_path(@source.app, @source)
end

step "I view the request of the n+1 query" do
  visit app_request_path(@request.app, @request)
end
