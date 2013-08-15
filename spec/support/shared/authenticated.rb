shared_context "App authentication" do
  let(:app) { App.make!(:with_access_token) }
  let(:authorization) { bearer_auth(app) }
  let(:headers) { {"HTTP_AUTHORIZATION" => authorization} }
  before do
    headers.each do |header, value|
      @request.env[header] = value
    end
  end
end

def bearer_auth(app)
  "Bearer #{app.current_access_token.token}"
end
