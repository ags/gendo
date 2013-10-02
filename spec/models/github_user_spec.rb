require "spec_helper"

describe GithubUser do
  describe ".find_or_initialize" do
    let(:access_token) { '6d4dbae87749ecf8c2678d2635c7cd18d74b76a0' }

    around do |example|
      VCR.use_cassette('gendo-test-github-user-data') do
        example.run
      end
    end

    context "when a user with the associated github user id does not exist" do
      it "initializes one with github data" do
        user = GithubUser.find_or_initialize(access_token)

        expect(user.github_access_token).to eq(access_token)
        expect(user.github_user_id).to eq(5514833)
        expect(user.email).to eq("alex.geoffrey.smith+gendotest@gmail.com")
        expect(user.name).to eq("Gendo Test")
        expect(user.new_record?).to eq(true)
      end
    end

    context "when a user with the associated github user id exists" do
      it "updates the User's github data" do
        existing = User.make!(github_user_id: 5514833, name: "Bob")

        user = GithubUser.find_or_initialize(access_token)

        expect(user.new_record?).to eq(false)
        expect(existing.id).to eq(user.id)
        expect(user.name).to eq("Gendo Test")
      end
    end
  end
end
