require "spec_helper"

describe ApiV1::ApiController, "error handling" do
  controller(ApiV1::ApiController) do
    def index
      raise RuntimeError, "an error occured"
    end
  end

  it "responds with status 500" do
    get :index
    expect(response.status).to eq(500)
  end

  it "responds with error type, message and backtrace" do
    get :index
    json = JSON.parse(response.body)
    expect(json["type"]).to eq("RuntimeError")
    expect(json["message"]).to eq("an error occured")
    expect(json["backtrace"]).to be_present
  end

  context "in production" do
    before do
      Rails.env.stub(:production?) { true }
    end

    it "only responds with the error type" do
      get :index
      expect(response.body).to eq({"type" => "RuntimeError"}.to_json)
    end
    it "responds with status 500" do
      get :index
      expect(response.status).to eq(500)
    end
  end
end

describe ApiV1::ApiController, "error handling" do
  let!(:app) { App.make!(:with_access_token) }

  controller(ApiV1::ApiController) do
    def index
      render json: {id: current_app.id}
    end
  end

  context "when an authorization header is provided" do
    before do
      @request.env["HTTP_AUTHORIZATION"] = bearer_auth(app)
    end

    it "responds wih status 200" do
      get :index
      expect(response.status).to eq(200)
      expect(response.body).to eq({"id" => app.id}.to_json)
    end
  end

  context "when an authorization header missing 'Bearer' is provided" do
    before do
      @request.env["HTTP_AUTHORIZATION"] = app.current_access_token.token
    end

    it "responds with 401 Unauthorized" do
      get :index
      expect(response.status).to eq(401)
      expect(response.message).to eq("Unauthorized")
    end
  end

  context "when no authorization header is provided" do
    it "responds with 401 Unauthorized" do
      get :index
      expect(response.status).to eq(401)
      expect(response.message).to eq("Unauthorized")
    end
  end
end
