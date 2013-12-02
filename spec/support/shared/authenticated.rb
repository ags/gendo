shared_context "App authentication" do
  let(:app) { App.make!(:with_access_token) }
  let(:authorization) { bearer_auth(app.current_access_token) }
  let(:headers) { {"HTTP_AUTHORIZATION" => authorization} }
  before do
    headers.each do |header, value|
      @request.env[header] = value
    end
  end
end

shared_examples_for "a request requring authorization" do
  context "without authorization" do
    it "responds with 401 Unauthorized" do
      get url

      expect_missing_authorization
    end
  end

  context "without valid authorization" do
    let(:headers) { {"HTTP_AUTHORIZATION" => "Bearer foobar"} }

    it "responds with 404 not found" do
      get url, nil, headers

      expect_not_found
    end
  end
end

def bearer_auth(access_token)
  "Bearer #{access_token.token}"
end
