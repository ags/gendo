shared_examples_for "an access token" do
  describe ".generate" do
    subject(:access_token) { described_class.generate(model) }

    around do |example|
      tokens = %w(first_token second_token)
      described_class.token_generator = ->{
        @_tokens_generated ||= 0
        token = tokens[@_tokens_generated]
        @_tokens_generated += 1
        token
      }

      example.run

      described_class.token_generator = nil
    end

    it "instantiates a new #{described_class}" do
      model_name = model.class.name.downcase
      expect(access_token.__send__(model_name)).to eq(model)
      expect(access_token.token).to eq('first_token')
    end

    it "does not persist the token" do
      expect(access_token.persisted?).to eq(false)
    end

    context "if a #{described_class} already exists with the generated token" do
      before do
        described_class.make!(token: 'first_token')
      end

      it "generates a different token" do
        expect(access_token.token).to eq('second_token')
      end
    end
  end
end
