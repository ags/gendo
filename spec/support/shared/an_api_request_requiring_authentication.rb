shared_examples_for "an api request requiring authentication" do
  it "responds with 401 Unauthorized" do
    action!

    expect(response.status).to eq(401)
    expect(response.message).to eq("Unauthorized")
  end
end
