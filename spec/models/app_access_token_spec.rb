require 'spec_helper'

describe AppAccessToken do
  describe ".generate" do
    let(:app) { App.new }
    subject(:app_access_token) { AppAccessToken.generate(app) }

    around do |example|
      tokens = %w(first_token second_token)
      AppAccessToken.token_generator = ->{
        @_tokens_generated ||= 0
        token = tokens[@_tokens_generated]
        @_tokens_generated += 1
        token
      }

      example.run

      AppAccessToken.token_generator = nil
    end

    it "instantiates a new AppAccessToken" do
      expect(app_access_token.app).to eq(app)
      expect(app_access_token.token).to eq('first_token')
    end

    it "does not persist the token" do
      expect(app_access_token.persisted?).to eq(false)
    end

    context "if a AppAccessToken already exists with the generated token" do
      before do
        AppAccessToken.make!(token: 'first_token')
      end

      it "generates a different token" do
        expect(app_access_token.token).to eq('second_token')
      end
    end
  end
end
