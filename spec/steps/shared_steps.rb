step "I'm signed in" do
  user = User.make!
  visit bypass_url(user_id: user.id)
end

step "there is a User:" do |table|
  details = table.hashes.first
  User.make!(email: details["Email"], password: details["Password"])
end

step "I should see :something" do |something|
  expect(page).to have_content(something)
end
