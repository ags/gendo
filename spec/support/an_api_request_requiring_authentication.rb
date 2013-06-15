shared_examples_for "an api request requiring authentication" do
  before do
    action!
  end

  it "requires an authentication header" do
    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
  end
end
